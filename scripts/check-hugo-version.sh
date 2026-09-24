#!/usr/bin/env sh
# Comprueba que el Hugo disponible es la versión extended fijada en mise.toml.
# Evita compilar con la versión por defecto de la imagen de Workers Builds (ver MIGRACION.md §14).
set -eu
expected=$(sed -n 's/^hugo-extended *= *"\(.*\)"/\1/p' mise.toml)
actual=$(hugo version 2>/dev/null || true)
case "$actual" in
  "hugo v${expected}-"*"+extended"*)
    echo "Hugo ${expected} extended: OK" ;;
  *)
    echo "ERROR: se esperaba Hugo ${expected} extended (mise.toml) y se encontró: ${actual:-ninguno}" >&2
    echo "En local: mise install. En Workers Builds, scripts/build.sh instala la versión correcta en ./.bin." >&2
    exit 1 ;;
esac
