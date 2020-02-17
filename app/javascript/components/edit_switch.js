import { toggleZone } from 'components/toggle_zone'

const editBtn = document.querySelector('#tlk-toggle-edit');
const editZone = document.querySelector('#tlk-section-edit');
const readZone = document.querySelector('#tlk-section-read');

const editSwitch = () => {
  editBtn.addEventListener('click', (event) => {
    changeBtnTextAndClass();
    toggleZone(editZone);
    toggleZone(readZone);
  });
}

export { editSwitch }

const changeBtnTextAndClass = () => {
  if (editBtn.innerText == "Edit Taaalk Details") {
    editBtn.innerText = "Exit Edit Mode";
    editBtn.classList.add("edit-mode-on");
    // editBtn.classList.remove("edit-mode-on");
  } else {
    editBtn.innerText = "Edit Taaalk Details";
    editBtn.classList.remove("edit-mode-on");
    // editBtn.classList.remove("edit-mode-off");
  }
}
