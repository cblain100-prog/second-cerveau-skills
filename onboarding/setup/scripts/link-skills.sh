#!/bin/bash
# Rend visibles pour Claude Code les skills du cerveau, SANS rien mettre dans le .claude/ du cerveau.
# Les skills vivent dans "Skills/<skill>/" (racine du cerveau) et "1 Terrains/<Terrain>/Skills/<skill>/".
# Claude Code ne lit que .claude/skills/ (projet) ou ~/.claude/skills/ (utilisateur) : on pose les liens
# dans ~/.claude/skills/, en dehors du cerveau. Lancé au SessionStart par le hook posé par install.sh. Idempotent.
# Ne touche qu'aux liens qui pointent vers CE cerveau : les autres skills de ~/.claude/skills/ restent intacts.
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ROOT="$(cd "$ROOT" && pwd -P)"
DEST="$HOME/.claude/skills"
[ -d "$ROOT/Skills" ] || [ -d "$ROOT/1 Terrains" ] || exit 0   # pas un cerveau : rien à faire
mkdir -p "$DEST"
# 1. purge des liens qui pointaient vers ce cerveau (skill renommé ou supprimé)
for l in "$DEST"/*; do
  [ -L "$l" ] || continue
  t="$(cd "$(dirname "$l")" 2>/dev/null && cd "$(readlink "$l")" 2>/dev/null && pwd -P)" || { rm -f "$l"; continue; }
  case "$t" in "$ROOT"/*) rm -f "$l";; esac
done
# 2. un lien par skill
link_one() {
  local skill="$1" name; name="$(basename "$skill")"
  if [ -e "$DEST/$name" ]; then echo "skill déjà présent dans ~/.claude/skills, non remplacé : $name" >&2; return; fi
  ln -s "$skill" "$DEST/$name"
}
[ -d "$ROOT/Skills" ] && find "$ROOT/Skills" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d '' s; do link_one "$s"; done
[ -d "$ROOT/1 Terrains" ] && find "$ROOT/1 Terrains" -mindepth 3 -maxdepth 3 -path "*/Skills/*" -type d -print0 | while IFS= read -r -d '' s; do link_one "$s"; done
exit 0
