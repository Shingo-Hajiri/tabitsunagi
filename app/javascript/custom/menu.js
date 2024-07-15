function initializeHamburgerMenu() {
  const open = document.getElementById('open');
  const close = document.getElementById('close');
  const menu = document.getElementById('menu');

  if (open && close && menu) {
    open.classList.remove('hidden');
    close.classList.add('hidden');
    menu.classList.add('hidden');
    
    open.addEventListener('click', () => {
      console.log('Open clicked'); 
      open.classList.add('hidden');
      close.classList.remove('hidden');
      menu.classList.remove('hidden');
    });
  
    close.addEventListener('click', () => {
      close.classList.add('hidden');
      open.classList.remove('hidden');
      menu.classList.add('hidden');
    });
  }
}

document.addEventListener('turbo:load', initializeHamburgerMenu);
document.addEventListener('DOMContentLoaded', initializeHamburgerMenu);
document.addEventListener('turbo:render', initializeHamburgerMenu);
document.addEventListener('turbo:submit-end', initializeHamburgerMenu);
