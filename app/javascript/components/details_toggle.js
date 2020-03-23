import { toggleZone } from 'components/toggle_zone'

let detailsBtn = document.querySelector('#create-spkr-user-edit-form-btn');
let detailsZone = document.querySelector('#create-spkr-user-edit-form');

const detailsToggle = () => {
  detailsBtn.addEventListener('click', (event) => {
    changeToggleBtnTextAndClass();
    toggleZone(detailsZone);
  });
}

export { detailsToggle }


const changeToggleBtnTextAndClass = () => {
  if (detailsBtn.innerHTML == 'Leave Your Details &nbsp;<i class="fas fa-pencil-alt"></i>') {
    detailsBtn.innerText = "Close";
    var detailsString = 'Leave Your Details &nbsp;<i class="fas fa-pencil-alt"></i>'
  } else {
    if (detailsBtn.innerHTML == 'Update Your Details &nbsp;<i class="fas fa-pencil-alt"></i>') {
      detailsBtn.innerText = "Close";
      var detailsString = 'Update Your Details &nbsp;<i class="fas fa-pencil-alt"></i>'
    } else {
      if (detailsBtn.classList.contains('leave-class')) {
        detailsBtn.innerHTML = 'Leave Your Details &nbsp;<i class="fas fa-pencil-alt"></i>'
      } else {
        detailsBtn.innerHTML = 'Update Your Details &nbsp;<i class="fas fa-pencil-alt"></i>'
      }
    }
  }
}
