document.addEventListener('DOMContentLoaded', initializeSpotButton);
document.addEventListener('turbo:load', initializeSpotButton);
document.addEventListener('turbo:render', initializeSpotButton);

function initializeSpotButton() {
  const addSpotButton = document.getElementById("add-spot");
  if (addSpotButton) {
    addSpotButton.removeEventListener("click", addSpotButtonClickHandler);
    addSpotButton.addEventListener("click", addSpotButtonClickHandler);
  }
}

function addSpotButtonClickHandler() {
  const spotFieldsTemplate = document.getElementById("spot-fields-template");
  if (spotFieldsTemplate) {
    var content = spotFieldsTemplate.innerHTML;
    var uniqueId = new Date().getTime();
    content = content.replace(/new_spot/g, uniqueId);
    document.getElementById("spots").insertAdjacentHTML('beforeend', content);
    addRemoveButtonEventListeners(); // 新しいスポットを追加した後にイベントリスナーを再設定

    // 新しく追加されたスポットに対してオートコンプリートを初期化
    if (typeof initializeAutocomplete === 'function') {
      initializeAutocomplete();
    } else {
      console.error('initializeAutocomplete function is not defined');
    }
  }
}

function addRemoveButtonEventListeners() {
  document.querySelectorAll('.remove-spot').forEach(function(button) {
    button.removeEventListener('click', removeSpotButtonClickHandler);
    button.addEventListener('click', removeSpotButtonClickHandler);
  });
}

function removeSpotButtonClickHandler() {
  this.closest('.spot-fields').remove();
}