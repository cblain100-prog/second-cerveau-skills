#!/bin/bash
# Installe la plomberie d'un second cerveau sur une machine : sync git + releve du soir des messageries.
# A lancer APRES le skill /onboarding (qui cree les fichiers), depuis n'importe ou.
#
#   bash install.sh /chemin/vers/le/vault [heure_routine]
#
# Idempotent : relançable sans casser ce qui existe.

set -u
KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="${1:-}"
RECAP_HOUR="${2:-23}"

if [ -z "$VAULT_DIR" ] || [ ! -d "$VAULT_DIR" ]; then
  echo "Usage : bash install.sh /chemin/vers/le/vault [heure_routine, defaut 23]"
  exit 1
fi
VAULT_DIR="$(cd "$VAULT_DIR" && pwd)"
VAULT_NAME="$(basename "$VAULT_DIR")"
SLUG="$(echo "$VAULT_NAME" | tr '[:upper:] ' '[:lower:]-' | tr -cd 'a-z0-9-')"
CLAUDE_BIN="$(command -v claude || echo "$HOME/.local/bin/claude")"

echo "Vault  : $VAULT_DIR"
echo "Routine: ${RECAP_HOUR}h00"
echo

# ------------------------------------------- 0. Version de Claude Code (AGENTS.md)
# Le cerveau utilise AGENTS.md (lu aussi par Codex). Claude Code ne le charge
# qu'a partir de la 2.1.277 : en dessous, la session demarre sans aucun contexte.
CC_VERSION="$("$CLAUDE_BIN" --version 2>/dev/null | awk '{print $1}')"
CC_MIN="2.1.277"
if [ -n "$CC_VERSION" ] && [ "$(printf '%s\n%s\n' "$CC_MIN" "$CC_VERSION" | sort -V | head -1)" != "$CC_MIN" ]; then
  echo "Claude Code $CC_VERSION < $CC_MIN : mise a jour (AGENTS.md ne serait pas lu)..."
  "$CLAUDE_BIN" update || echo "ATTENTION : mise a jour impossible, lance 'claude update' a la main avant d'ouvrir le cerveau."
fi

# ---------------------------------------------------------------- 1. Git local
cd "$VAULT_DIR"
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  git init -q -b main
  echo "[1/5] depot git cree"
else
  echo "[1/5] depot git deja present"
fi

# .gitignore : rien de sensible ni de lourd ne part sur GitHub
if [ ! -f .gitignore ]; then
  cat > .gitignore <<'EOG'
.env
.env.*
!.env.example
.DS_Store
node_modules/
__pycache__/
*.log
.claude/settings.local.json
EOG
  echo "      .gitignore cree"
fi

if [ -z "$(git log -1 2>/dev/null)" ]; then
  git add -A && git commit -q -m "Initialisation du second cerveau"
  echo "      premier commit fait"
fi

# ------------------------------------------------------ 2. Scripts de sync
mkdir -p "$VAULT_DIR/.claude/scripts"
cp "$KIT_DIR/scripts/session-pull.sh" "$VAULT_DIR/.claude/scripts/"
cp "$KIT_DIR/scripts/session-push.sh" "$VAULT_DIR/.claude/scripts/"
cp "$KIT_DIR/scripts/link-skills.sh" "$VAULT_DIR/.claude/scripts/"
chmod +x "$VAULT_DIR/.claude/scripts/"*.sh
echo "[2/5] scripts de sync et de liaison des skills installes"

# ------------------------------------------------------ 3. Hooks SessionStart / SessionEnd
SETTINGS="$VAULT_DIR/.claude/settings.json"
python3 - "$SETTINGS" <<'EOP'
import json, os, sys
path = sys.argv[1]
data = {}
if os.path.exists(path):
    try:
        data = json.load(open(path))
    except Exception:
        os.rename(path, path + ".corrompu")
        data = {}
hooks = data.setdefault("hooks", {})
for event, script in (("SessionStart", "session-pull.sh"), ("SessionStart", "link-skills.sh"), ("SessionEnd", "session-push.sh")):
    cmd = 'bash "$CLAUDE_PROJECT_DIR/.claude/scripts/%s"' % script
    entries = hooks.setdefault(event, [])
    existing = [h.get("command") for e in entries for h in e.get("hooks", [])]
    if cmd not in existing:
        entries.append({"hooks": [{"type": "command", "command": cmd}]})
json.dump(data, open(path, "w"), indent=2, ensure_ascii=False)
print("      hooks pull/push branches")
EOP
echo "[3/5] hooks configures"

# ------------------------------------------------------ 4. Routine du soir (launchd)
TASK_DIR="$HOME/.claude/scheduled-tasks/daily-recap-$SLUG"
mkdir -p "$TASK_DIR" "$HOME/.claude/logs"
cp "$KIT_DIR/routine/daily-recap.md" "$TASK_DIR/SKILL.md"

LABEL="com.claude.schedule.daily-recap-$SLUG"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
cat > "$PLIST" <<EOPL
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key><string>$LABEL</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>-c</string>
      <string>cd "$VAULT_DIR" &amp;&amp; "$CLAUDE_BIN" -p "Lis le fichier $TASK_DIR/SKILL.md et execute exactement les instructions qu il contient, dans le vault courant ($VAULT_DIR). Ne pose aucune question, travaille en autonomie totale, termine proprement." --dangerously-skip-permissions ; CLAUDE_PROJECT_DIR="$VAULT_DIR" bash "$VAULT_DIR/.claude/scripts/session-push.sh"</string>
    </array>
    <key>EnvironmentVariables</key>
    <dict>
      <key>PATH</key><string>$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin</string>
      <key>HOME</key><string>$HOME</string>
    </dict>
    <key>StartCalendarInterval</key>
    <dict><key>Hour</key><integer>$RECAP_HOUR</integer><key>Minute</key><integer>0</integer></dict>
    <key>StandardOutPath</key><string>$HOME/.claude/logs/daily-recap-$SLUG.log</string>
    <key>StandardErrorPath</key><string>$HOME/.claude/logs/daily-recap-$SLUG.error.log</string>
    <key>RunAtLoad</key><false/>
</dict>
</plist>
EOPL
launchctl unload "$PLIST" 2>/dev/null
launchctl load "$PLIST" 2>/dev/null
echo "[4/5] releve du soir des messageries installe (${RECAP_HOUR}h00, label $LABEL)"

# ------------------------------------------------------ 5. GitHub distant
echo "[5/5] depot distant"
if git remote get-url origin >/dev/null 2>&1; then
  echo "      origin deja configure : $(git remote get-url origin)"
elif command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  gh repo create "$SLUG" --private --source=. --remote=origin --push && \
    echo "      depot prive GitHub cree et pousse" || \
    echo "      echec de la creation, faire le remote a la main"
else
  cat <<EOM
      GitHub n'est pas encore connecte sur cette machine.
      A faire une seule fois, dans le terminal :

        brew install gh
        gh auth login
        cd "$VAULT_DIR" && gh repo create $SLUG --private --source=. --remote=origin --push

      Le depot DOIT etre prive : le vault contient des informations personnelles.
      Tout le reste est deja installe et fonctionne en local.
EOM
fi

echo
echo "Termine."
echo "Verifier la routine        : launchctl list | grep $SLUG"
echo "Declencher la routine      : launchctl start $LABEL"
echo "Journal des synchros       : ~/Library/Logs/${VAULT_NAME}-session-push.log"
