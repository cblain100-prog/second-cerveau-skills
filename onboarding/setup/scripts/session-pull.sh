#!/bin/bash
# SessionStart hook : recupere ce qui a ete pousse depuis un autre poste ou par la routine du soir.
# Rapide, non bloquant : pas de reseau ou verrou occupe, la session continue quand meme.

VAULT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_NAME="$(basename "$VAULT_DIR")"
LOG_FILE="$HOME/Library/Logs/${VAULT_NAME}-session-pull.log"
LOCK="$HOME/Library/Caches/${VAULT_NAME}-git.lock.d"
TS=$(date "+%Y-%m-%d %H:%M:%S")

cd "$VAULT_DIR" 2>/dev/null || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0
git remote get-url origin >/dev/null 2>&1 || exit 0
mkdir -p "$(dirname "$LOG_FILE")"

# Verrou anti-collision (mkdir = atomique, pas de flock sur macOS). Vole le verrou perime (> 5 min).
[ -d "$LOCK" ] && [ -n "$(find "$LOCK" -maxdepth 0 -mmin +5 2>/dev/null)" ] && rmdir "$LOCK" 2>/dev/null
tries=0
while ! mkdir "$LOCK" 2>/dev/null; do
  tries=$((tries+1))
  [ $tries -gt 20 ] && { echo "[$TS] verrou occupe, pull skippe" >> "$LOG_FILE"; exit 0; }
  sleep 1
done
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

# Commit du local AVANT de pull : un working tree sale ne bloque jamais l'ouverture.
if [ -n "$(git status --porcelain)" ]; then
  git add -A >> "$LOG_FILE" 2>&1
  git commit -q -m "session-start $(date '+%Y-%m-%d %H:%M') (auto-commit avant pull)" >> "$LOG_FILE" 2>&1
fi

export GIT_SSH_COMMAND="ssh -o ConnectTimeout=8 -o BatchMode=yes"
BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo main)"

if git pull --rebase --autostash origin "$BRANCH" >> "$LOG_FILE" 2>&1; then
  echo "[$TS] pull OK" >> "$LOG_FILE"
else
  echo "[$TS] pull KO (offline ou conflit), session continue" >> "$LOG_FILE"
  git rebase --abort >> "$LOG_FILE" 2>&1 || true
  osascript -e 'display notification "Recuperation echouee, sync a verifier" with title "Second cerveau" sound name "Basso"' 2>/dev/null || true
fi
exit 0
