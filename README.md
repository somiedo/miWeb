# miWeb: web personal de Pablo García

Web personal y blog: biografía, trayectoria, certificaciones y artículos sobre análisis de datos con R y Python.

- **Generador:** [Hugo](https://gohugo.io/) extended con la plantilla
  [Academic CV de HugoBlox](https://hugoblox.com/templates/academic-cv) (Tailwind CSS v4, búsqueda con Pagefind).
- **Alojamiento:** [Cloudflare Workers](https://developers.cloudflare.com/workers/static-assets/) como Worker de solo
  assets estáticos, desplegado con Workers Builds desde este repositorio.
- **Historia:** migrada desde Wowchemy v5 (antes publicada en `somiedo.github.io`). Detalles en [MIGRACION.md](MIGRACION.md).

## Requisitos

Las versiones están fijadas en [`mise.toml`](mise.toml):

| Herramienta | Versión |
|---|---|
| Hugo extended | 0.162.0 |
| Go (para los módulos de Hugo) | 1.27.1 |
| Node.js | 22.23.3 |
| pnpm | 10.14.0 |

En macOS:

```bash
brew install mise
mise install          # dentro del repo: instala las versiones de mise.toml
pnpm install          # Tailwind, Pagefind…
```

## Uso en local

```bash
pnpm dev              # hugo server en http://localhost:1313 (recarga en vivo)
pnpm build            # compilación de producción en public/ + índice de búsqueda
```

## Estructura

| Ruta | Contenido |
|---|---|
| `content/_index.md` | Portada: bloques de biografía, habilidades, trayectoria, certificaciones, posts y contacto |
| `content/blog/<slug>/index.md` | Posts (imagen de cabecera: `featured.*` en la misma carpeta) |
| `data/authors/pablo.yaml` | Perfil: bio, enlaces, formación, experiencia, habilidades y certificaciones |
| `config/_default/` | Configuración de Hugo y HugoBlox (`params.yaml`: identidad, tema, SEO, analítica) |
| `assets/media/` | Avatar, favicon (`icon.png`) y logos propios (`icons/custom/`) |
| `assets/dist/font/` | Fuentes autoalojadas (sin Google Fonts) |
| `static/uploads/` | PDFs (CV, certificados) |
| `layouts/` | Personalizaciones: redirecciones (`index.redirects`) y hook de Cloudflare Web Analytics |
| `i18n/es.yaml` | Traducciones propias que sustituyen a las de HugoBlox |

### Añadir un post

1. Crea `content/blog/<slug>/index.md` con este front matter:

   ```yaml
   ---
   title: Título del post
   summary: Resumen para listados y buscadores
   date: 2026-01-31
   authors:
     - pablo
   tags:
     - etiqueta
   ---
   ```

2. Añade `featured.jpg` (o `.png`/`.webp`) en la misma carpeta como imagen de cabecera.
3. Comprueba con `pnpm dev` y haz commit.

## Despliegue

Cada push a `master` lo compila y despliega Cloudflare (Workers Builds), con estas variables de entorno de compilación,
que deben coincidir con `mise.toml`: `HUGO_VERSION`, `GO_VERSION`, `NODE_VERSION` y `PNPM_VERSION`.
La configuración del Worker está en `wrangler.jsonc` (sirve `public/`, con página 404 propia).
Las redirecciones de URLs antiguas se generan en `public/_redirects`.

## Licencia

Código bajo MIT y contenido bajo CC BY 4.0. Ver [LICENSE.md](LICENSE.md).
