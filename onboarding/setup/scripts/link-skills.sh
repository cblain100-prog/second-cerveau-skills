#!/bin/bash
# Reconstruit .claude/skills/ comme un dossier de liens vers les Skills/ visibles.
# Les skills vivent dans "Skills/<skill>/" (perso, racine du cerveau) et dans
# "1 Terrains/<Terrain>/Skills/<skill>/" (business, partagés avec l'équipe par Drive).
# Claude Code ne lit que .claude/skills/, donc on y pose un lien par skill.
# Lancé au SessionStart par le hook posé par install.sh. Idempotent.
# Drive ne synchronise pas les liens : chaque poste les recrée localement.
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
DEST="$ROOT/.claude/skills"
cd "$ROOT" 2>/dev/null || exit 0
mkdir -p "$DEST"
# purge des liens seulement (jamais un vrai dossier : un skill encore non déplacé reste intact)
find "$DEST" -mindepth 1 -maxdepth 1 -type l -delete
link_one() {
  local skill="$1" name
  name="$(basename "$skill")"
  [ -e "$DEST/$name" ] && { echo "doublon de skill ignoré : $skill" >&2; return; }
  ln -s "../../$skill" "$DEST/$name"   # $skill est relatif à la racine, DEST est racine/.claude/skills
}
[ -d "Skills" ] && find "Skills" -mindepth 1 -maxdepth 1 -type d -print0 | while IFS= read -r -d '' s; do link_one "$s"; done
[ -d "1 Terrains" ] && find "1 Terrains" -mindepth 3 -maxdepth 3 -path "*/Skills/*" -type d -print0 | while IFS= read -r -d '' s; do link_one "$s"; done
exit 0
