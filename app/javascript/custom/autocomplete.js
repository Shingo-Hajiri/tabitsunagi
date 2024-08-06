// Initialize Google Maps Places Autocomplete
function initialize() {
  initializeAutocomplete();
}

// Function to initialize autocomplete for all existing inputs
function initializeAutocomplete() {
  let options = {
    types: ['establishment'],
    componentRestrictions: { country: 'JP' },
  };

  document.querySelectorAll('.spot-fields').forEach((spotField) => {
    let storeInput = spotField.querySelector('input[id^="store"]');
    let addressInput = spotField.querySelector('input[id^="address"]');
    let inputUrl = spotField.querySelector('input[id^="url"]');
    let inputOpen = spotField.querySelector('input[id^="opening"]');
    let inputPhone = spotField.querySelector('input[id^="phone"]');
    
    if (storeInput) {
      let autocomplete = new google.maps.places.Autocomplete(storeInput, { types: ['establishment'] });
      autocomplete.addListener('place_changed', function () {
        let place = autocomplete.getPlace();
        if (addressInput) {
          storeInput.value = place.name;
          addressInput.value = place.formatted_address;
          inputUrl.value = place.website;
          inputPhone.value = place.formatted_phone_number || '';
          if (place.opening_hours && place.opening_hours.weekday_text) {
            inputOpen.value = place.opening_hours.weekday_text.join(', ');
          } else {
            inputOpen.value = '営業時間情報はありません';
          }
        }
      });
    }
  });
}

window.initializeAutocomplete = initializeAutocomplete;

// Initialize autocomplete for existing spots on page load
document.addEventListener('DOMContentLoaded', initialize);
document.addEventListener('turbo:load', initialize);
document.addEventListener('turbo:render', initialize);