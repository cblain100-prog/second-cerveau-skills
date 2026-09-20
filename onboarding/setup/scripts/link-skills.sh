#!/bin/bash
# Rend les skills du cerveau visibles pour CHAQUE outil, sans rien mettre dans le cerveau lui-même.
# Les skills vivent dans "Skills/<skill>/" (racine du cerveau) et "1 Terrains/<Terrain>/Skills/<skill>/" :
# c'est le format portable (un dossier par skill, un SKILL.md dedans). Chaque outil cherche les skills
# à une adresse fixe dans le dossier personnel de l'utilisateur, et suit les raccourcis :
#   Claude Code : ~/.claude/skills/      Codex : ~/.agents/skills/
# Le script pose un raccourci par skill à chaque adresse. Lancé au SessionStart (hook) ; relançable à la main.
# Ne touche qu'aux raccourcis qui pointent vers CE cerveau : les autres skills de l'utilisateur restent intacts.
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
ROOT="$(cd "$ROOT" && pwd -P)"
[ -d "$ROOT/Skills" ] || [ -d "$ROOT/1 Terrains" ] || exit 0   # pas un cerveau : rien à faire
DESTS="$HOME/.claude/skills $HOME/.agents/skills"

collect() {
  [ -d "$ROOT/Skills" ] && find "$ROOT/Skills" -mindepth 1 -maxdepth 1 -type d
  [ -d "$ROOT/1 Terrains" ] && find "$ROOT/1 Terrains" -mindepth 3 -maxdepth 3 -path "*/Skills/*" -type d
}
for DEST in $DESTS; do
  mkdir -p "$DEST"
  # 1. purge des raccourcis qui pointaient vers ce cerveau (skill renommé ou supprimé)
  for l in "$DEST"/*; do
    [ -L "$l" ] || continue
    t="$(cd "$(dirname "$l")" 2>/dev/null && cd "$(readlink "$l")" 2>/dev/null && pwd -P)" || { rm -f "$l"; continue; }
    case "$t" in "$ROOT"/*) rm -f "$l";; esac
  done
  # 2. un raccourci par skill
  collect | while IFS= read -r skill; do
    name="$(basename "$skill")"
    if [ -e "$DEST/$name" ]; then echo "skill déjà présent dans $DEST, non remplacé : $name" >&2; continue; fi
    ln -s "$skill" "$DEST/$name"
  done
done
exit 0
