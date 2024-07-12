function initializeHamburgerMenu() {
  const open = document.getElementById('open');
  const close = document.getElementById('close');
  const menu = document.getElementById('menu');

  if (open && close && menu) {
    console.log('Initializing hamburger menu');
    open.addEventListener('click', () => {
      console.log('Open clicked'); 
      open.classList.add('hidden');
      close.classList.remove('hidden');
      menu.classList.remove('hidden');
    });
  
    close.addEventListener('click', () => {
      console.log('Close clicked');
      close.classList.add('hidden');
      open.classList.remove('hidden');
      menu.classList.add('hidden');
    });
  } else {
    console.log('Elements not found:', { open, close, menu }); // 要素の確認
  }
}

document.addEventListener('turbo:load', initializeHamburgerMenu);
document.addEventListener('DOMContentLoaded', initializeHamburgerMenu);
document.addEventListener('turbo:submit-end', initializeHamburgerMenu);

