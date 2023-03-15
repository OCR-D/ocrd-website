/*
 * for bulma
 */
function fixBulmanNavbarBurgers() {

  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target from the "data-target" attribute
        const target = $el.dataset.target;
        const $target = document.getElementById(target);

        // Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      })
    })
  }

}

document.addEventListener('DOMContentLoaded', fixBulmanNavbarBurgers)

/*
 * table of contents toggle
 */
const sidebarToggle = document.querySelector('#toc-sidebar-toggle')
if (sidebarToggle) {
  const sidebarContent = document.querySelector('#toc-sidebar')
  const mainContent = document.querySelector('main')
  sidebarToggle.onclick = function onClickSidebarToggle () {
    sidebarToggle.classList.toggle('closed')
    sidebarContent.classList.toggle('is-one-third')
    sidebarContent.classList.toggle('is-hidden')
    mainContent.classList.toggle('is-two-thirds')
  }
}

/*
 * Toggle google search
 */
function ToggleSearchActive2() {
  document.getElementById("button-header").style.display = "none";
  document.getElementById("google-search-header").style.visibility = "visible";
}

/*
 * - Linkify videos in publications list / hide non-URL video (stemming from
 *   reusing the CSL short-title field for video URL)
 * - fix the `doi.org//` links
 */
function linkifyVideosInPublications() {
  const label = ' Video: '
  document.querySelectorAll('.csl-entry').forEach(entry => {
    const entry_text = entry.innerHTML
    if (entry_text.indexOf(label) > -1) {
      let [part_before, part_after] = entry_text.split(label)
      if (part_after.indexOf('https://') > -1) {
        // contains a link, linkify
        part_after = part_after.replace('&lt;', '').replace('&gt;', '').replace(/\.$/, '')
        link_label = part_after
        if (link_label.length > 50) {
          link_label = `${link_label.substr(0, 50)}...`
        }
        part_after = `${label}&lt;<a href=${part_after}>${link_label}</a>&gt;.`
      } else {
        // contains something else, hide
        part_after = ''
        part_before = part_before.replace(/ ;$/, '.')
      }
      entry.innerHTML = `${part_before}${part_after}`
    }
    entry.querySelectorAll('a').forEach(link => {
      if (link.href.indexOf('https://doi.org//') === 0) {
        link.href = link.href.replace('https://doi.org//', '/')
      }
    })
  })
}

