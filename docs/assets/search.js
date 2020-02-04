/* global lunr */

const Q = (...args) => document.querySelector(...args)

fetch('/search-index.json')
  .then(resp => resp.json())
  .then(entries => {
    const idx = lunr(function() {
      this.field('title')
      this.field('content', {boost: 10})
      this.field('url')
      entries.forEach((entry, i) => this.add({id: i, ...entry}))
      Q("#search").onclick = () => {
        const q = Q("#search-input").value
        const results = idx.search(q)
        Q('#result-number').innerHTML = `${results.length} results found`
        Q('#search-results').innerHTML = ''
        results.forEach(({ref, score}) => {
          const {url, content} = entries[ref]
          Q('#search-results').innerHTML += `<li>${score}<a href=${url}>${content.substring(0, 100)}</a></li>`
        })
        console.log({q, idx, results})
      }
    })
  })
