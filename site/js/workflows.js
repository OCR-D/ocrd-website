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
            ${trProcessor.innerHTML}
            <tr>
              <table>
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
            </tr>
          </table>
        </td>
        `
      //trProcessor.parentNode.insertBefore(trAfter, trProcessor.nextSibling)
    })
  })
})
