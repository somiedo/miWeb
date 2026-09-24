# Fuentes autoalojadas

HugoBlox usa un fichero `assets/dist/font/<Nombre>*` en lugar de Google Fonts si existe
(`modules/blox/layouts/_partials/functions/typography.html`). Pack tipográfico: `academic`.

| Fichero | Familia | Origen (npm, subconjunto latin) |
|---|---|---|
| `Lora.var.woff2` | Lora (variable, wght) | `@fontsource-variable/lora@5.3.0` → `files/lora-latin-wght-normal.woff2` |
| `SourceSerif4.var.woff2` | Source Serif 4 (variable, wght) | `@fontsource-variable/source-serif-4@5.3.0` → `files/source-serif-4-latin-wght-normal.woff2` |
| `SourceCodePro.woff2` | Source Code Pro 400 | `@fontsource/source-code-pro@5.3.0` → `files/source-code-pro-latin-400-normal.woff2` |

Licencia: SIL Open Font License 1.1 (ver `licenses/`). El subconjunto latin (U+0000-00FF, …) cubre el español.
