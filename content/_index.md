---
# Título vacío: usa el nombre del sitio
title: ''
summary: ''
type: landing

sections:
  - block: resume-biography-3
    id: biografia
    content:
      username: pablo
      text: ''
      button:
        text: Descarga mi CV
        url: uploads/CV_PABLO_GARCIA_MARTIN_Bioinf.pdf
      headings:
        about: Biografía
        education: Formación
        interests: Intereses
    design:
      background:
        gradient_mesh:
          enable: true
      name:
        size: md
      avatar:
        size: medium
        shape: circle

  - block: resume-skills
    id: habilidades
    content:
      title: Habilidades
      username: pablo

  - block: resume-experience
    id: trayectoria
    content:
      title: Trayectoria
      username: pablo
    design:
      date_format: 'January 2006'
      is_education_first: false

  - block: resume-awards
    id: certificaciones
    content:
      title: Certificaciones
      username: pablo
    design:
      date_format: 'January 2006'

  - block: collection
    id: blog
    content:
      title: Últimos posts
      page_type: blog
      count: 5
      offset: 0
      order: desc
      filters:
        exclude_future: false
        exclude_past: false
    design:
      view: date-title-summary
      columns: '1'

  - block: markdown
    id: contacto
    content:
      title: Contacto
      text: |-
        ¿Quieres comentar un proyecto o simplemente charlar? Escríbeme a
        [pablo.somiedo@gmail.com](mailto:pablo.somiedo@gmail.com) o encuéntrame en
        [GitHub](https://github.com/somiedo), [LinkedIn](https://www.linkedin.com/in/pablosomiedo/)
        y [X](https://x.com/pabloSomiedo).
    design:
      columns: '1'
---
