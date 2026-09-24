#!/usr/bin/env sh
# Instala Hugo extended (versión de mise.toml) en ./.bin desde las releases oficiales de GitHub,
# verificando el SHA-256 contra los hashes fijados abajo.
# Se usa en Workers Builds: su imagen instala HUGO_VERSION en edición estándar, no extended (ver MIGRACION.md §14).
# Al cambiar de versión de Hugo, actualiza los hashes con los de hugo_<versión>_checksums.txt de la release.
set -eu
version=$(sed -n 's/^hugo-extended *= *"\(.*\)"/\1/p' mise.toml)

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64)  platform=linux-amd64 ;;
  Linux-aarch64) platform=linux-arm64 ;;
  *) echo "ERROR: plataforma no soportada por install-hugo.sh: $(uname -s)-$(uname -m). Usa mise install." >&2; exit 1 ;;
esac

case "${version}-${platform}" in
  0.162.0-linux-amd64) sha256=b118d52077bcb301c8d8031f116c04d9dd848e4a5cab572ca10905ea94791216 ;;
  0.162.0-linux-arm64) sha256=183462187e0a16928f76831c3c05266e8174cb6ff010612621c199bc59b3a16e ;;
  *) echo "ERROR: no hay hash SHA-256 fijado para Hugo ${version} (${platform}) en scripts/install-hugo.sh." >&2; exit 1 ;;
esac

file="hugo_extended_${version}_${platform}.tar.gz"
url="https://github.com/gohugoio/hugo/releases/download/v${version}/${file}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

echo "Descargando ${url}"
curl -fsSL --retry 5 --retry-all-errors -o "${tmp}/${file}" "$url"
echo "${sha256}  ${tmp}/${file}" | sha256sum -c -
mkdir -p .bin
tar -xzf "${tmp}/${file}" -C .bin hugo
.bin/hugo version
