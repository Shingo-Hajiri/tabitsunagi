function initializeHamburgerMenu() {
  const open = document.getElementById('open');
  const close = document.getElementById('close');
  const menu = document.getElementById('menu');
  const body = document.body;

  if (open && close && menu) {
    open.classList.remove('hidden');
    close.classList.add('hidden');
    menu.classList.add('hidden');
    
    open.addEventListener('click', () => {
      open.classList.add('hidden');
      close.classList.remove('hidden');
      menu.classList.remove('hidden');
      body.classList.add('body-no-scroll');
    });
  
    close.addEventListener('click', () => {
      close.classList.add('hidden');
      open.classList.remove('hidden');
      menu.classList.add('hidden');
      body.classList.remove('body-no-scroll');
    });
  }
}

document.addEventListener('turbo:load', initializeHamburgerMenu);
document.addEventListener('DOMContentLoaded', initializeHamburgerMenu);
document.addEventListener('turbo:render', initializeHamburgerMenu);
document.addEventListener('turbo:submit-end', initializeHamburgerMenu);
