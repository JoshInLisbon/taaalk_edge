import { toggleZone } from 'components/toggle_zone'

const editBtn = document.querySelector('#tlk-toggle-edit');
const editZone = document.querySelector('#tlk-section-edit');
const readZone = document.querySelector('#tlk-section-read');

const editSwitch = () => {
  editBtn.addEventListener('click', (event) => {
    changeBtnText();
    toggleZone(editZone);
    toggleZone(readZone);
  });
}

export { editSwitch }

const changeBtnText = () => {
  if (editBtn.innerText == "Edit This Taalk") {
    editBtn.innerText = "Edit Mode Off";
  } else {
    editBtn.innerText = "Edit This Taalk";
  }
}
