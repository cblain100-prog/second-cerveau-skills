#!/bin/bash
# SessionEnd hook : pousse ce qui vient d'etre ecrit des que la session se ferme.
# Sert aussi de post-traitement a la routine du soir (appele par le plist).

VAULT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
VAULT_NAME="$(basename "$VAULT_DIR")"
LOG_FILE="$HOME/Library/Logs/${VAULT_NAME}-session-push.log"
LOCK="$HOME/Library/Caches/${VAULT_NAME}-git.lock.d"
TS=$(date "+%Y-%m-%d %H:%M:%S")

cd "$VAULT_DIR" 2>/dev/null || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0
git remote get-url origin >/dev/null 2>&1 || exit 0
mkdir -p "$(dirname "$LOG_FILE")"

# --- Detachement : le hook SessionEnd est tue par l'app au bout de quelques secondes.
# On relance le script en arriere-plan, detache, et on rend la main tout de suite.
if [ "${VAULT_PUSH_DETACHED:-}" != "1" ]; then
  export VAULT_PUSH_DETACHED=1
  export CLAUDE_PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$VAULT_DIR}"
  nohup bash "$0" >/dev/null 2>&1 &
  disown 2>/dev/null || true
  exit 0
fi


[ -d "$LOCK" ] && [ -n "$(find "$LOCK" -maxdepth 0 -mmin +5 2>/dev/null)" ] && rmdir "$LOCK" 2>/dev/null
tries=0
while ! mkdir "$LOCK" 2>/dev/null; do
  tries=$((tries+1))
  [ $tries -gt 30 ] && { echo "[$TS] verrou occupe 30s, push abandonne" >> "$LOG_FILE"; exit 0; }
  sleep 1
done
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

export GIT_SSH_COMMAND="ssh -o ConnectTimeout=10 -o BatchMode=yes"
BRANCH="$(git symbolic-ref --short HEAD 2>/dev/null || echo main)"

if [ -n "$(git status --porcelain)" ]; then
  git add -A >> "$LOG_FILE" 2>&1
  git commit -q -m "session-end $(date '+%Y-%m-%d %H:%M')" >> "$LOG_FILE" 2>&1
fi

# Pull avant push : integre ce qui a ete ecrit ailleurs pendant la session.
if ! git pull --rebase --autostash origin "$BRANCH" >> "$LOG_FILE" 2>&1; then
  echo "[$TS] rebase en conflit, fallback distant" >> "$LOG_FILE"
  git rebase --abort >> "$LOG_FILE" 2>&1 || true
  git fetch origin "$BRANCH" >> "$LOG_FILE" 2>&1
  git merge -X theirs "origin/$BRANCH" --no-edit >> "$LOG_FILE" 2>&1 || true
fi

if git push origin "$BRANCH" >> "$LOG_FILE" 2>&1; then
  echo "[$TS] push OK" >> "$LOG_FILE"
else
  echo "[$TS] PUSH KO, voir log" >> "$LOG_FILE"
  osascript -e 'display notification "Sauvegarde echouee, sync a verifier" with title "Second cerveau" sound name "Basso"' 2>/dev/null || true
fi
exit 0
