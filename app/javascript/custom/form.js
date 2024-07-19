document.addEventListener('turbo:load', function() {
  // スポットの追加ボタンにクリックイベントリスナーを追加
  const addSpotButton = document.getElementById("add-spot");
  if (addSpotButton) {
    // イベントリスナーがすでに追加されているか確認する
    if (!addSpotButton.hasAttribute('data-listener-added')) {
      addSpotButton.addEventListener("click", addSpotButtonClickHandler);
      addSpotButton.setAttribute('data-listener-added', 'true');
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
    }
  }

  function addRemoveButtonEventListeners() {
    // 削除ボタンにイベントリスナーを設定
    document.querySelectorAll('.remove-spot').forEach(function(button) {
      button.removeEventListener('click', removeSpotButtonClickHandler);
      button.addEventListener('click', removeSpotButtonClickHandler);
    });
  }

  function removeSpotButtonClickHandler() {
    this.closest('.spot-fields').remove();
  }

  // 初期読み込み時と新しいスポット追加時にイベントリスナーを設定
  addRemoveButtonEventListeners();
});
