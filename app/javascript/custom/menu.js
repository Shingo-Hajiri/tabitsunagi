document.addEventListener('turbo:load', () => {
  const open = document.getElementById('open');
  const close = document.getElementById('close');
  const menu = document.getElementById('menu');

  open.addEventListener('click', () => {
    open.classList.add('hidden');
    close.classList.remove('hidden');
    menu.classList.remove('hidden');
  });

  close.addEventListener('click', () => {
    close.classList.add('hidden');
    open.classList.remove('hidden');
    menu.classList.add('hidden');
  });
});