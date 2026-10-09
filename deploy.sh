#!/usr/bin/env bash
# ============================================================
#  Despliegue de FIJA a GitHub Pages  (sincronización con token)
#  Uso:
#     GITHUB_REPO=tucuenta/FIJA GITHUB_TOKEN=ghp_xxx ./deploy.sh
#  - GITHUB_REPO : "usuario/repo"  (p. ej. tucuenta/FIJA)
#  - GITHUB_TOKEN: token clásico con permiso `repo`
#  El token viaja SOLO en la URL del push de este comando; no se guarda.
#  Nota: en el entorno WorkBuddy hay un hook post-commit que ya empuja main
#  automáticamente en cada commit (token cacheado), así que los cambios se
#  publican solos sin necesidad de correr este script.
# ============================================================
set -e

if [ -z "$GITHUB_REPO" ] || [ -z "$GITHUB_TOKEN" ]; then
  echo "Faltan variables: usa  GITHUB_REPO=tucuenta/FIJA GITHUB_TOKEN=ghp_xxx ./deploy.sh" >&2
  exit 1
fi

REMOTE="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPO}.git"

git add -A
if git diff --cached --quiet; then
  echo "Sin cambios que subir."
else
  git commit -m "Actualización FIJA $(date '+%Y-%m-%d %H:%M:%S')"
fi

git push "$REMOTE" main
echo ""
echo "✅  Subido a $GITHUB_REPO."
echo "    Espera ~30-60 s y revisa tu URL de GitHub Pages."
