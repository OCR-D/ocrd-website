---
layout: page
lang: en
lang-ref: kwalitee
toc: true
title: Module Processors
---

{%- for repo in site.data.ocrd-repo -%}

<div class="column">
  <div class="tile is-ancestor">
    <div class="tile is-parent ocrd-module {{ repo.name }}">
      <h2 class="title">{{ repo.name }}</h2>
      {% if repo.compliant_cli %}
      <span class="icon has-text-success">
        <i class="fas fa-check-square"></i>
      </span>
      {% else %}
      <span class="icon has-text-warning">
        <i class="fas fa-exclamation-triangle"></i>
      </span>
      {% endif %}
      <p>{{ repo.description | markdownify }}</p>
    </div>
  </div>
</div>

{%- endfor -%}

