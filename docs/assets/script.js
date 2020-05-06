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

const sidebarToggle = document.querySelector('#toc-sidebar-toggle')
if (sidebarToggle) {
  const sidebarContent = document.querySelector('#toc-sidebar-content')
  const mainContent = document.querySelector('main')
  sidebarToggle.onclick = function onClickSidebarToggle () {
    sidebarContent.classList.toggle('is-one-third')
    sidebarContent.classList.toggle('is-hidden')
    mainContent.classList.toggle('is-two-thirds')
  }
}
