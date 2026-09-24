# Migración de Wowchemy v5 → HugoBlox (Academic CV) + Cloudflare Workers

Documento de trabajo de la migración. Fase 0 (inventario y auditoría) realizada el 2026-09-24
sobre el commit `5d7c77b` (`origin/master`, 2023-04-15, "eliminada la carpeta public").

---

## 0. Estado del repositorio local (hallazgo crítico)

- La copia local está en **OneDrive** (`~/Library/CloudStorage/OneDrive-Personal/GitHub/miWeb`).
  OneDrive ha dejado **1080 ficheros de `.git` y 5 del árbol de trabajo en estado *dataless***
  (marcadores sin contenido local) y no los descarga: `git log` y `git diff` fallan con
  `fatal: mmap failed: Operation timed out`.
- Los 109 ficheros que `git status` marca como modificados solo difieren en **fines de línea (CRLF)**.
  Verificado comparando byte a byte (ignorando `\r`) con un clon limpio de GitHub: **no hay
  cambios de contenido sin subir**. Los 5 ficheros ilegibles son vacíos (`.gitkeep`, `.hugo_build.lock`).
- Lo único local no versionado es `resources/_gen/` (caché regenerable) y `assets/jsconfig.json` (ignorado).
- `master` local == `origin/master` == `5d7c77b`. La rama local `lists` existe pero no se ha podido inspeccionar.
- **Conclusión:** el clon de GitHub contiene todo el contenido. La auditoría se ha hecho sobre él.

## 1. Inventario de contenido real

### Perfil de autor
| Elemento | Origen | Valor / notas |
|---|---|---|
| Nombre | `content/authors/pablo/_index.md` | Pablo García |
| Rol | idem | "Data scientist de la Vida" |
| Organizaciones | idem | Universidad Complutense de Madrid, Universitat Oberta de Catalunya |
| Bio corta | idem | "Biólogo que no para de estudiar, ahora Bioinformático y Bioestadístico…" |
| Bio larga | cuerpo del `_index.md` | 3 párrafos + enlace de descarga del CV (`staticref` a `uploads/CV_PABLO_GARCIA_MARTIN_Bioinf.pdf`) |
| Intereses | idem | Biología de la conservación, Ecología de poblaciones, Análisis de datos, R y Python |
| Educación | idem | Máster Bioinformática y Bioestadística (UOC/UB, 2023); Licenciado CC. Biológicas (UCM, 1994) |
| Redes | idem | email, Twitter (@pabloSomiedo), GitHub (somiedo), LinkedIn (pablosomiedo) |
| Avatar | `content/authors/pablo/avatar.jpg` | 3360×3306, 1,6 MB, EXIF de cámara (sin GPS) |
| **Duplicado** | `content/authors/admin/` | Copia antigua de `pablo` (mismo avatar; bio 2022 y CV 2022). **Los posts usan `authors: [admin]`**, así que es el autor que se muestra en los posts. |

### Portada (widgets en `content/home/`)
| Widget | Fichero | Activo | Peso | Equivalente HugoBlox |
|---|---|---|---|---|
| about | `about.md` | sí | 20 | bloque `resume-biography-3` + `data/authors/me.yaml` |
| featurette (Skills: R, Python, SQL, GitHub, QGis, Estadística) | `skills.md` | sí | 30 | `skills` en `me.yaml` + bloque `resume-skills` (o `tech-stack`/`features`) |
| experience (Trayectoria, 3 entradas) | `experience.md` | sí | 40 | `experience` en `me.yaml` + bloque `resume-experience` |
| accomplishments (Formación/Certificaciones, 7 entradas) | `accomplishments.md` | sí | 50 | `awards` en `me.yaml` + bloque `resume-awards` (no hay bloque específico de certificaciones) |
| pages (Últimos posts, 5, vista compact) | `posts.md` | sí | 60 | bloque `collection` |
| tag_cloud (Etiquetas) | `tags.md` | sí | 120 | **sin bloque equivalente** (ver §4) |
| contact (con formulario Netlify + CAPTCHA) | `contact.md` | sí | 130 | bloque `contact-info` (**sin formulario**, ver §4) |
| blank "cabecera" (fondo `neurona.jfif`) | `cabecera.md` | no | 15 | — |
| demo, featured, projects, publications, talks | varios | no | — | contenido del starter, se descarta |

### Experiencia (`experience.md`)
1. MEDIO AMBIENTE — TRAGSA · SEO · DYPSA-ENTORNO — 1993-07 → actualidad — logo `medio_ambiente.svg`
2. DESARROLLO WEB — FREELANCE — 2008-04 → actualidad — logo `web.svg`
3. TIC — CAPGEMINI · MODUS MANAGEMENT — 2000-11 → 2012-04 — logo `tic.svg`

### Certificaciones (`accomplishments.md`)
Curso maestro de Python 3 (Udemy, 2021-02) · Excel Total (Udemy, 2021-09) · Curso de QGIS (MappingGIS, 2016-01)
· Machine Learning Data Science en Python (Udemy, 2019-02) · Tensorflow para ML e IA (Udemy, 2019-03)
· Tensorflow 2.0 Guía completa (Udemy, 2019-12) · RPAS Pilot Certificate (Spanish-ATO, 2014-11, PDF propio).

### Posts (`content/post/`)
| Carpeta | Título | Estado | Fecha | Recursos |
|---|---|---|---|---|
| `primer-post` | Primer post | **publicado** | 2021-11-25 | `featured.webp`, `profesor_pizarra.jpg` |
| `tomando-notas-con-logseq` | Tomando notas con Logseq | **publicado** | 2023-04-15 | `featured.webp`, `logseq-escritorio.webp` |
| `iniciacion-git` | Iniciación a Git | borrador | 2021-12-01 | `featured.png`, `git_repo.webp` |
| `01-carga-de-datos` | Carga de datos en R | borrador | 2022-02-23 | `featured.jpg` (tag mal formado: `"RStudio, data"` como una sola etiqueta) |
| `getting-started` | Welcome to Wowchemy… | borrador | — | **demo del starter → eliminar** |

URLs actuales de los posts: `/post/<slug>/`. Taxonomías: `/tag/:slug/`, `/category/:slug/`.

### Publicaciones, proyectos, charlas, slides
Todo es **contenido de ejemplo del starter** (`publication/example`, `project/example`, `event/example`, `slides/example`).
No tienes publicaciones, proyectos ni charlas propias.

### CV y documentos (`static/uploads/`)
| Fichero | Uso |
|---|---|
| `CV_PABLO_GARCIA_MARTIN_Bioinf.pdf` | CV actual (enlazado desde el autor `pablo`) |
| `PABLO_GARCIA_MARTIN_2022_Bioinf.pdf` | CV 2022 (enlazado solo desde el autor `admin`) |
| `Pablo_Garcia.pdf` | sin referencias → ¿CV antiguo? |
| `certificado-drones.pdf` | enlazado desde certificaciones |
| `MappingGIS_titulo_QGIS_Pablo.pdf` | **referenciado pero no existe → enlace roto** |

### Imágenes y medios
- `assets/media/cabecera.png` y `static/media/cabecera.png`: duplicados (mismo tamaño). Solo los usaba la cabecera inactiva.
- `assets/media/neurona.jfif`: fondo de la cabecera inactiva.
- `assets/media/icon.png`: favicon/logo del sitio.
- `assets/media/icons/brands/*.svg`: iconos propios → `medio_ambiente`, `web`, `tic` (logos de experiencia),
  `MappingGIS`, `Spanish-ATO`, `Udemy`, `Udemy1`, `coursera`, `datacamp`, `edx` (certificaciones).
  `org-gc.svg` y `org-x.svg` son del starter.
- `images/screenshot.png`, `images/tn.png`: capturas del starter (para el catálogo de temas de Hugo).

### Idioma / i18n
- Idioma único: español (`defaultContentLanguage: es`, `languageCode: es-Es`), `removePathAccents: true`.
- `i18n/ES.yaml`: 79 cadenas traducidas (sobrescritura del i18n de Wowchemy). HugoBlox trae su propio `es`;
  hay que revisar qué cadenas propias siguen haciendo falta.

### Menú (`config/_default/menus.yaml`)
Home (`#about`) · Blog (`#posts`) · Contacto (`#contact`). Resto comentado. Sin enlace al CV en el menú.

### Contacto y redes (`config/_default/params.yaml`)
- Email `pablo.somiedo@gmail.com`, teléfono, dirección (Madrid, CP y **coordenadas exactas**).
- `contact_links`: Twitter `@pabloSomiedo`, **Skype** (`join.skype.com/invite/…`).
- Botones de compartir (`data/page_sharer.toml`): Twitter, Facebook, Email, LinkedIn, WhatsApp, Weibo.

### Analítica / SEO
- **Google Tag Manager `GTM-PP3R66M`**. `privacy_pack: false` (sin aviso de cookies).
- `description: ''` (sin meta descripción), `twitter: ''`, sin verificación de Search Console.
- `enableRobotsTXT: true`. Sitemap por defecto de Hugo.

### Apariencia
- Tema de color `Forest`, `font_size: L`, conmutador claro/oscuro activo, búsqueda activa (motor Wowchemy).
- `assets/scss/custom.scss`: barra de navegación clara con título y menú en verde `#4caf50`, texto en mayúsculas,
  sombra. En HugoBlox (Tailwind v4) no aplica SCSS: habrá que trasladarlo a color de marca/CSS de Tailwind.
- Resaltado de código para R, Python y LaTeX.

## 2. Personalizaciones propias vs. código heredado del starter

**Propio (a migrar):** autor `pablo` (y bio de `admin` como histórico), widgets about/skills/experience/accomplishments/
posts/contact/tags con su contenido, 4 posts (2 publicados, 2 borradores) con sus imágenes, PDFs de `static/uploads`,
iconos SVG propios, `icon.png`, avatar, `custom.scss` (colores), `i18n/ES.yaml`, datos de contacto, menú, GTM,
`config.yaml` (título, copyright, idioma), `SubirCambios.md` (flujo antiguo, se sustituye).

**Heredado del starter (sin valor propio):** `exampleSite/` (121 ficheros, copia del demo de Wowchemy),
contenido `*/example`, `post/getting-started`, `authors/admin` (duplicado), `home/{demo,featured,projects,publications,talks}.md`,
`content/admin/` y módulo `wowchemy-cms` (Netlify CMS), `privacy.md`/`terms.md` (plantilla en borrador),
`theme.toml`, `images/`, `scripts/init_kickstart.sh`, `update_wowchemy.sh`, `view.sh`, `netlify.toml`,
`LICENSE.md` (MIT de George Cushen), `.editorconfig`, `go.mod`/`go.sum` (módulo `github.com/wowchemy/starter-hugo-academic`).
No hay carpeta `layouts/` propia en la raíz: **no hay plantillas personalizadas que portar**.

## 3. Ficheros a eliminar (propuesta, pendiente de confirmar en Fase 3)

- `exampleSite/` completo
- `netlify.toml`, `update_wowchemy.sh`, `view.sh`, `theme.toml`, `scripts/init_kickstart.sh`, `images/`
- `.hugo_build.lock` (versionado por error), `.gitmodules` (submódulo `public` → `somiedo.github.io`, ya sin gitlink)
- `SubirCambios.md` (flujo de submódulo sustituido por GitHub Actions; su contenido útil irá al README)
- `content/admin/`, `content/authors/admin/`, `content/post/getting-started/`, `content/*/example/`,
  `content/home/` (se sustituye por `content/_index.md` con bloques), `content/privacy.md`, `content/terms.md` (salvo que quieras redactarlos)
- `data/page_sharer.toml`, `data/fonts/`, `data/themes/`, `assets/jsconfig.json`, `assets/scss/` (tras trasladar colores)
- `static/media/cabecera.png` (duplicado), `assets/media/icons/brands/org-{gc,x}.svg`
- `resources/_gen/` (caché; ya ignorada)
- `academic.Rproj`: **pendiente de tu decisión**

## 4. Contenido sin equivalente directo en HugoBlox

| Elemento | Situación | Propuesta |
|---|---|---|
| Nube de etiquetas (`tag_cloud`) | No existe bloque `tag-cloud` en el kit actual | Enlazar a `/tags/` desde el menú o un bloque `markdown` |
| Formulario de contacto (Netlify Forms) | Netlify Forms no existe en Cloudflare; `contact-info` no tiene formulario | Solo email/redes; o servicio externo (Formspree) más adelante |
| Certificaciones con URL de certificado | Se mapean a `awards` | Verificar que `resume-awards` muestra enlace e icono |
| Logos SVG en experiencia/certificaciones | El esquema `me.yaml` puede no admitir iconos propios por entrada | Verificar en Fase 2; si no, se pierden los logos |
| Cabecera "blank" con imagen de fondo (inactiva) | — | No se migra (estaba desactivada) |
| Búsqueda Wowchemy | Sustituida por Pagefind | Automático con la plantilla |
| Botones de compartir configurables | Configuración distinta | Revisar en Fase 2 |
| Categorías (`categories`) | La plantilla solo define `tags`, `authors`, `publication_types` | Añadir taxonomía `categories` o fusionarlas en tags |
| Netlify CMS (`content/admin`) | Eliminado | No se migra |
| `custom.scss` | Tailwind v4, sin SCSS | Traducir a color primario del tema |

## 5. Riesgos detectados

1. **Repo dentro de OneDrive (alto).** `.git` con objetos sin descargar, fallos de `git`, conversión CRLF,
   riesgo de corrupción y conflictos de sincronización (y `node_modules/`, `public/`, `resources/` se sincronizarían).
   Recomendación: clonar de nuevo fuera de OneDrive (p. ej. `~/Developer/miWeb`) y trabajar ahí.
2. **Sin herramientas.** Solo hay `git` (Apple). No hay Homebrew, Hugo, Go, Node, pnpm ni Wrangler.
3. **Cambio de URLs de posts.** La plantilla usa `content/blog/` (`/blog/<slug>/`) en lugar de `/post/<slug>/`.
   Opciones: mantener la carpeta `post` o crear redirecciones 301 con `_redirects` (Workers Static Assets lo admite).
   Impacto bajo: la web antigua no se está sirviendo (ver 9).
4. **Datos personales públicos.** Teléfono móvil y coordenadas exactas de tu domicilio en `params.yaml`.
   Recomendación: publicar solo email y redes.
5. **Analítica sin consentimiento.** GTM sin aviso de cookies (RGPD/LSSI). Opciones: quitarla, analítica sin cookies
   (Cloudflare Web Analytics) o añadir banner de consentimiento.
6. **Enlaces obsoletos.** Skype cerró en mayo de 2025; Twitter es ahora X; PDF de MappingGIS inexistente;
   botón de compartir en Weibo heredado del demo.
7. **Discrepancia de requisitos de Node.** La guía CLI dice Node ≥ 18, pero el módulo `blox` exige Hugo ≥ 0.161.1
   y su comentario indica que desde Hugo 0.161.0 Tailwind requiere **Node ≥ 22**; el `netlify.toml` y el workflow
   oficiales usan Node 22. Se fija Node 22.
8. **Versión de Go del template obsoleta.** `netlify.toml` oficial fija Go 1.21.5 (sin soporte). Hugo Modules solo necesita
   el binario de Go; se propone la estable actual.
9. **La web antigua está caída.** `https://somiedo.github.io/` devuelve 404 y el repo `somiedo.github.io` no es público
   (404 anónimo). No hay tráfico que romper.
10. **Borradores.** Dos posts en `draft: true`; hay que decidir si se migran como borradores.
11. **Licencia.** `LICENSE.md` es la MIT del starter (George Cushen). Decidir licencia para tu contenido.
12. **Rama `lists`.** Existe en local, no en remoto, y no se ha podido leer por el problema de OneDrive.

## 6. Versiones a fijar y su origen

| Herramienta | Versión propuesta | Fuente |
|---|---|---|
| Hugo **extended** | **0.162.0** | `hugoblox.yaml` (`build.hugo_version`) y `netlify.toml` de la plantilla oficial Academic CV (`HugoBlox/kit/templates/academic-cv`, rama `main`). Mínimo del módulo: 0.161.1 (`modules/blox/hugo.yaml`, `hugoVersion.min`, `extended: true`). Última publicada: 0.166.0 (no probada por HugoBlox). |
| Node.js | **22.23.3** (línea 22) | `NODE_VERSION: '22'` en `.github/workflows/build.yml` y `netlify.toml` de la plantilla; última 22.x en nodejs.org/dist/index.json |
| pnpm | **10.14.0** | `packageManager` en `package.json` de la plantilla (se activa con Corepack) |
| Go | **1.27.1** | go.dev/VERSION (estable actual). La plantilla indica 1.21.5 (EOL); `go.mod` exige ≥ 1.19 |
| Wrangler | **4.138.0** (devDependency) | registry.npmjs.org/wrangler/latest |
| cloudflare/wrangler-action | **v4.1.2** | GitHub releases |
| Tailwind / Pagefind | las del `pnpm-lock.yaml` de la plantilla | `package.json`: `tailwindcss ^4.1.12`, `@tailwindcss/cli ^4.1.12`, `pagefind ^1.4.0` |

## 7. Decisiones

Tomadas el 2026-09-24:

- [x] Repo de trabajo: clon nuevo en `~/cloudflare/miWeb` (fuera de OneDrive), rama `hugoblox`.
- [x] `academic.Rproj`: se elimina.
- [x] Herramientas: Homebrew + mise (versiones fijadas en `mise.toml`), pnpm vía Corepack.
- [x] URLs de posts: pasan a `/blog/<slug>/`, con redirección 301 desde `/post/<slug>/` (`_redirects`).
- [x] Contacto: se quitan teléfono, dirección y coordenadas; solo email y redes.
- [x] Analítica: se sustituye GTM por Cloudflare Web Analytics.
- [x] Posts en borrador (`iniciacion-git`, `01-carga-de-datos`) y PDFs antiguos (`Pablo_Garcia.pdf`,
      `PABLO_GARCIA_MARTIN_2022_Bioinf.pdf`): se eliminan (siguen en el historial de git de `master`).
- [x] Rama local `lists`: origen desconocido. Solo existe en la copia de OneDrive, que se deja intacta como respaldo.
- [x] Despliegue: el repo vive en GitHub y Cloudflare apunta a él (ver §9).

- [x] Repo de GitHub: se sigue con `somiedo/miWeb` (se conserva el historial).
- [x] Despliegue: **Workers Builds** (Cloudflare conectado al repo). Sustituye al workflow de GitHub Actions
      de la Fase 5 original: sin API token ni secrets en GitHub.
- [x] Licencia: código bajo MIT y contenido (textos, imágenes, PDFs) bajo CC BY 4.0.

## 9. Despliegue: Workers Builds frente a GitHub Actions

Según <https://developers.cloudflare.com/workers/ci-cd/builds/> y `.../builds/build-image/` (consultado el 2026-09-24):

- **Workers Builds (Cloudflare → GitHub):** se conecta el repo desde el panel de Cloudflare
  (Worker → Settings → Builds → Connect). Cloudflare compila y despliega en cada push a la rama de producción
  y crea URLs de preview para otras ramas o PR. No hacen falta API tokens ni secrets en GitHub.
  La imagen trae Hugo extended 0.147.7, Go 1.24.3 y Node 24.18.0 por defecto (demasiado antiguo para HugoBlox, que
  exige Hugo ≥ 0.161.1), pero se fijan con las variables `HUGO_VERSION`, `GO_VERSION`, `NODE_VERSION` y `PNPM_VERSION`,
  o con `.node-version`/`.nvmrc` en el caso de Node.
- **GitHub Actions (GitHub → Cloudflare):** el plan original de la Fase 5. Requiere un API token de Cloudflare y los secrets
  `CLOUDFLARE_API_TOKEN` y `CLOUDFLARE_ACCOUNT_ID` en GitHub.

## 8. Registro de cambios de URL

Redirecciones 301 generadas en `public/_redirects` por `layouts/index.redirects`:

| URL antigua | URL nueva | Motivo |
|---|---|---|
| `/post/` | `/blog/` | La plantilla usa la sección `blog` |
| `/post/primer-post/` | `/blog/primer-post/` | idem (regla `/post/*`) |
| `/post/tomando-notas-con-logseq/` | `/blog/tomando-notas-con-logseq/` | idem |
| `/tag/<etiqueta>/` | `/tags/<etiqueta>/` | Ruta de taxonomía de Hugo por defecto |
| `/category/opinion/`, `/category/herramientas/` | `/tags/opinion/`, `/tags/herramientas/` | Categorías fusionadas en etiquetas |
| `/uploads/PABLO_GARCIA_MARTIN_2022_Bioinf.pdf`, `/uploads/Pablo_Garcia.pdf` | `/uploads/CV_PABLO_GARCIA_MARTIN_Bioinf.pdf` | PDFs antiguos eliminados → CV actual |

Sin redirección (no aplica): anclas de la portada (`#about` → `#biografia`, `#posts` → `#blog`, `#contact` → `#contacto`;
los navegadores no envían el ancla al servidor), posts en borrador eliminados (nunca publicados),
y el contenido de demo (`/publication/`, `/project/`, `/talk/`…).

## 10. Fase 1: esqueleto HugoBlox (2026-09-24)

- **Entorno:** `mise.toml` fija Hugo extended 0.162.0, Go 1.27.1, Node 22.23.3 y pnpm 10.14.0 (`mise install`).
- **Método:** CLI oficial `hugoblox@0.12.8` (`hugoblox create site --template academic-cv --ci --no-preview`,
  telemetría desactivada con `hugoblox telemetry disable`), generado aparte y copiado al repo.
  En modo `--ci` no se genera contenido de ejemplo (solo `content/_index.md`, `data/authors/me.yaml` y `assets/media/authors/me.png`).
- **Módulo:** `go.mod` → `module github.com/somiedo/miWeb`. Módulos de HugoBlox fijados por pseudo-versión
  (`blox` 20260527, `slides` 20260330, `integrations/netlify` 20260327) y `go.sum` versionado.
  `hugoblox.yaml` → `deploy.host: cloudflare`.
- **Sustituido del sitio viejo:** `config/`, `content/`, `assets/`, `data/`, `i18n/`, `static/`, `go.mod`, `go.sum`, `.gitignore`.
  El contenido Wowchemy sigue en `master`: `git show master:<ruta>` o `git restore -s master -- <ruta>`.
- **No copiado de la plantilla:** `.github/` (workflows de GitHub Pages, upgrade semanal, import de publicaciones, FUNDING),
  `netlify.toml`, `.devcontainer/`, `.vscode/`, `.env` (token de HugoBlox Pro), `README.md`, `LICENSE.md`,
  `static/uploads/resume.pdf` (demo) y `layouts/_partials/hooks/head-end/github-button.html` (script externo de buttons.github.io).
- **Incidencias:**
  1. La CLI en modo `--ci` genera `content/_index.md` sin el `---` de cierre → corregido a mano (se reescribe en la Fase 2).
  2. **`_headers` mal formado** (fallo del módulo `integrations/netlify`): el recorte de espacios de `index.headers` pega `/*`
     con la primera cabecera (`/*X-XSS-Protection: …`) y omite `X-Frame-Options`. Cloudflare no aplicaría las cabeceras.
     Se corrige en la Fase 4 con un `layouts/index.headers` propio.
  3. pnpm ignora el script de build de `@parcel/watcher` (dependencia de Tailwind CLI para modo *watch*); la compilación no lo necesita.
- **Verificado:** `hugo --gc --minify` sin errores ni warnings (`--printPathWarnings --printI18nWarnings`), Pagefind indexa,
  `hugo server` sirve `/` (200) y una ruta inexistente devuelve la 404 propia.

## 11. Fase 2: migración de contenido (2026-09-24)

**Trasladado**
- Perfil → `data/authors/pablo.yaml` (esquema `hugoblox/author/v1`, `slug: pablo`, `is_owner: true`), avatar en
  `assets/media/authors/pablo.jpg`. Incluye bio, afiliaciones, enlaces, intereses, formación, experiencia,
  habilidades y certificaciones (como `awards`).
- Portada (`content/_index.md`): biografía con botón "Descarga mi CV" → habilidades → trayectoria → certificaciones →
  últimos posts → contacto (bloque `markdown`). Anclas: `#biografia`, `#habilidades`, `#trayectoria`, `#certificaciones`, `#blog`, `#contacto`.
- Posts publicados → `content/blog/` (autor `pablo`, categorías fusionadas en etiquetas en minúsculas).
  Rutas de imagen `./img` → `img` (el render hook de HugoBlox no resuelve `./`); texto alternativo significativo.
- Logos propios → `assets/media/icons/custom/` (`custom/<nombre>`): se muestran en experiencia y certificaciones.
- Config: idioma `es` (`locale: es-es`), menú Inicio/Blog/Etiquetas/Contacto, nombre, lema, descripción SEO, X `pabloSomiedo`,
  color primario `#4caf50`, fechas en español, licencia CC BY 4.0 en el pie, `frame_options: sameorigin`,
  sin selector de idioma ni selector de paletas ("Theme", sin traducir). Se elimina la taxonomía `publication_types`.
- `i18n/es.yaml`: "Trayectoria" y "Formación" en lugar de "Experiencia" y "Educación".
- Cloudflare Web Analytics: hook `layouts/_partials/hooks/body-end/cloudflare-web-analytics.html`, activo solo en
  producción cuando `params.cloudflare_web_analytics.token` tiene valor (token pendiente de crear en la Fase 4).

**Cambios y pérdidas respecto a Wowchemy**
- **Bio corta** ("Biólogo que no para de estudiar…"): el esquema nuevo solo tiene `bio`; se usa la bio larga.
- **Ubicación** "España" de cada experiencia: el bloque no tiene campo de ubicación → no se muestra.
- **Formación duplicada**: el bloque de trayectoria muestra siempre la formación del perfil, además de la tarjeta
  "Formación" de la biografía. Se añade `end` con el año para que no aparezca "Actualmente".
- **Habilidades**: sin niveles (no los había); el bloque las muestra en mayúsculas.
- **Contacto**: el bloque `contact-info` tiene textos en inglés fijos en el código ("Click to copy", "Send a message") →
  sustituido por un bloque `markdown`. Sin teléfono, dirección ni formulario.
- **Nube de etiquetas**: sustituida por el enlace "Etiquetas" (`/tags/`) del menú.
- **Curso de QGIS**: sin enlace (el PDF de MappingGIS no existía).
- **Enlaces de Udemy** (`ude.my/…`): pasados a https; redirigen a `udemy.com/s/?hash=…` y Udemy bloquea la comprobación
  automática (403). **Pendiente: comprobarlos a mano en el navegador.**
- Título de la pestaña de la 404: "404 Page not found" (valor por defecto de Hugo; el contenido de la página sí está en español).

**Verificado**
- `hugo --gc --minify` sin warnings; Pagefind indexa los 2 posts.
- Sin enlaces internos rotos (comprobación automática sobre la salida compilada) ni imágenes huérfanas
  (eliminado `assets/media/slides-logo.svg` de la plantilla); los 6 logos propios se renderizan.
- Revisión visual en `hugo server`: portada, post, listado del blog, 404, modo oscuro y claro, móvil (375 px) sin scroll horizontal.

**Riesgos nuevos**
- La plantilla carga fuentes desde Google Fonts (`fonts.googleapis.com`): transfiere la IP del visitante a Google
  (sentencia LG München 2022). Alternativa: autoalojar las fuentes. Pendiente de decisión.
- Pie con atribución "Made with Hugo Blox Kit" (`hugoblox.pro.hide_attribution: false`).
- `baseURL` sigue siendo `https://example.com/` hasta conocer la URL de `workers.dev` (Fase 4): afecta a sitemap,
  RSS, URL canónica y Open Graph.
