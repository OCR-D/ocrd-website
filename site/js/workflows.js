const toc = document.querySelector('#toc-sidebar-content')

// Toggle whether to show docker or native calls
let isDocker = false

// add 'see all parameters row'
fetch('/js/ocrd-all-tool.json').then(resp => resp.json()).then(json => {
  const FIELD_ORDER = ['name', 'description', 'type', 'default']
  Object.keys(json).forEach(processor => {
    const {parameters} = json[processor]
    document.querySelectorAll(`[data-processor="${processor}"]`).forEach(trProcessor => {
      trProcessor.innerHTML = `
        <td colspan="4">
          <table>
            <tbody>
              <tr class="processor-overview">${trProcessor.innerHTML}</tr>
              <tr class="parameter-row">
                  <td colspan=4>
                    <table class="parameter-table">
                      <thead>
                        <tr>
                          <th>name</th>
                          <th>description</th>
                          <th>type</th>
                          <th>default</th>
                        </tr>
                      </thead>
                      <tbody>
                        ${Object.keys(parameters).map(paramName => {
                          return `<tr>
                            <td><code>${paramName}</code></td>
                            <td>${parameters[paramName].description}</td>
                            <td>${parameters[paramName].type}</td>
                            <td>${parameters[paramName].default || '-'}</td>
                          </tr>`
                        }).join('')}
                      </tbody>
                    </table>
                  </td>
                </tr>
              </tbody>
          </table>
        </td>
        `
      const secondRow = trProcessor.querySelector('.parameter-row')
      secondRow.style.display = 'none'
      trProcessor.querySelector('td table tr td').style.color = 'blue'
      trProcessor.querySelector('td table tr td').style.textDecoration = 'underline'
      trProcessor.querySelector('td table tr td').addEventListener('click', function() {
        if (secondRow.style.display == 'none') {
          secondRow.style.display = 'revert'
        } else {
          secondRow.style.display = 'none'
        }
      })
    })
  })
})
