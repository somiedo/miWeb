# CLAUDE.md

Web personal de Pablo García: Hugo + HugoBlox (plantilla Academic CV) desplegada como Worker de solo assets en Cloudflare.
Idioma del sitio y de la documentación: español.

## Comandos

```bash
mise install                        # herramientas con las versiones de mise.toml
pnpm install --frozen-lockfile      # dependencias Node (Tailwind, Pagefind)
pnpm dev                            # hugo server en http://localhost:1313
pnpm build                          # hugo --gc --minify + Pagefind → public/
hugo --gc --minify --printPathWarnings --printI18nWarnings   # compilación con avisos
hugo mod graph                      # módulos HugoBlox y sus versiones
```

## Versiones fijadas

Hugo extended 0.162.0 · Go 1.27.1 · Node 22.23.3 · pnpm 10.14.0 (`mise.toml`).
Los módulos HugoBlox están fijados por pseudo-versión en `go.mod`/`go.sum`.
Si cambias una versión, actualiza también `mise.toml`, `hugoblox.yaml` (`build.hugo_version`), las variables de Workers Builds
(`HUGO_VERSION`, `GO_VERSION`, `NODE_VERSION`, `PNPM_VERSION`) y la tabla de `README.md`.

## Convenciones

- Perfil y CV en `data/authors/pablo.yaml` (esquema `hugoblox/author/v1`). Los posts usan `authors: [pablo]`.
- Posts en `content/blog/<slug>/index.md`, con la imagen de cabecera `featured.*` en la misma carpeta.
  Las imágenes internas se enlazan sin `./` (`![alt](imagen.webp)`); si no, el render hook de HugoBlox no las resuelve.
- Solo etiquetas (`tags`), sin categorías. Etiquetas en minúsculas.
- Iconos: `hero/<nombre>`, `brands/<nombre>` o `custom/<nombre>` (→ `assets/media/icons/custom/<nombre>.svg`).
- Personaliza HugoBlox con hooks (`layouts/_partials/hooks/<hook>/`), `i18n/es.yaml` y config, **sin copiar
  bloques del módulo** a `layouts/` salvo que sea imprescindible (dificulta las actualizaciones).
- Overrides existentes: `layouts/index.redirects` (301 de URLs antiguas) y `layouts/index.headers` (si existe;
  corrige el `_headers` mal formado del módulo `integrations/netlify`).
- Nada de secretos en el repo. El token de Cloudflare Web Analytics es público (`params.cloudflare_web_analytics.token`).
- No se usa Google Fonts: las fuentes están en `assets/dist/font/`.
- Rama de trabajo para cambios grandes; `master` despliega a producción.
- Registra en `MIGRACION.md` cualquier contenido o funcionalidad que se pierda o cambie de URL.
