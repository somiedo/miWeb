#!/usr/bin/env sh
# Compilación de producción: Hugo (versión extended de mise.toml) + índice de búsqueda Pagefind.
# Si el Hugo del sistema no es la versión exacta (p. ej. en Workers Builds), instala la fijada en ./.bin.
set -eu
version=$(sed -n 's/^hugo-extended *= *"\(.*\)"/\1/p' mise.toml)
case "$(hugo version 2>/dev/null || true)" in
  "hugo v${version}-"*"+extended"*) ;;
  *)
    [ -x .bin/hugo ] || sh scripts/install-hugo.sh
    PATH="$(pwd)/.bin:$PATH"; export PATH ;;
esac
sh scripts/check-hugo-version.sh
hugo --gc --minify
pnpm run pagefind
