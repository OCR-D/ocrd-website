---
layout: page
lang: en
lang-ref: kwalitee
toc: true
---


<table class="table"> <thead>
    <tr>
      GitHub
    </tr>
    <tr>
      Last update
    </tr>
    <tr>
      Number of contributors
    </tr>
  </thead> 
  <tbody>
    {% for repo in site.data.ocrd-repo %}
    <h2>{{ repo.name }}</h2>
    <pre>{{ repo }} </pre>
    {% endfor %}
  </tbody>
  <table>
