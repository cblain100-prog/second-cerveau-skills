#!/bin/bash
# Rend les skills visibles pour Claude Code et Codex, une fois pour toutes, sans rien mettre dans le cerveau.
#   ~/.claude/skills  (Claude Code)  et  ~/.agents/skills  (Codex)  →  raccourci vers le dossier Skills/ visible.
# Cas simple (un seul Skills/, à la racine du dossier ouvert) : UN raccourci sur le dossier entier. Un skill ajouté
# ou supprimé dans Skills/ est vu immédiatement, plus rien à relancer.
# Cas avancé (plusieurs Skills/ : racine + 1 Terrains/<X>/Skills/) : un raccourci par skill, relancer après un ajout.
# Si l'utilisateur a déjà de vrais skills à cette adresse, on ne les touche pas : raccourcis par skill à côté.
ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"; ROOT="$(cd "$ROOT" && pwd -P)"
DIRS=()
[ -d "$ROOT/Skills" ] && DIRS+=("$ROOT/Skills")
for d in "$ROOT"/1\ Terrains/*/Skills; do [ -d "$d" ] && DIRS+=("$d"); done
[ ${#DIRS[@]} -gt 0 ] || { echo "aucun dossier Skills/ dans $ROOT : rien à faire"; exit 0; }
for DEST in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
  mkdir -p "$(dirname "$DEST")"
  mine=0; if [ -L "$DEST" ]; then case "$(cd "$DEST" 2>/dev/null && pwd -P)" in "$ROOT"/*) mine=1;; esac; fi
  if [ ${#DIRS[@]} -eq 1 ] && { [ $mine -eq 1 ] || [ ! -e "$DEST" ] || [ -z "$(ls -A "$DEST" 2>/dev/null)" ]; }; then
    [ -d "$DEST" ] && [ ! -L "$DEST" ] && rmdir "$DEST"
    ln -sfn "${DIRS[0]}" "$DEST"; echo "$DEST → ${DIRS[0]}"
  else
    [ $mine -eq 1 ] && rm -f "$DEST"; mkdir -p "$DEST"
    for l in "$DEST"/*; do [ -L "$l" ] && case "$(cd "$l" 2>/dev/null && pwd -P)" in "$ROOT"/*|"") rm -f "$l";; esac; done
    for d in "${DIRS[@]}"; do for s in "$d"/*/; do n="$(basename "$s")"; [ -e "$DEST/$n" ] && { echo "déjà présent, non remplacé : $n" >&2; continue; }; ln -s "${s%/}" "$DEST/$n"; done; done
    echo "$DEST : un raccourci par skill (${#DIRS[@]} dossiers Skills/)"
  fi
done
exit 0
