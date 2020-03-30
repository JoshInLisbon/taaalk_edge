import { toggleZone } from 'components/toggle_zone'

const editBtn = document.querySelector('#tlk-toggle-edit');
const editBtns = document.querySelectorAll('.tlk-toggle-edit');
const editZone = document.querySelector('#tlk-section-edit');
const readZone = document.querySelector('#tlk-section-read');



const userEditSwitch = () => {
  editBtns.forEach(btn => {
    btn.addEventListener('click', (event) => {
      changeBtnTextAndClass();
      toggleZone(editZone);
      toggleZone(readZone);
    });
  });
}

export { userEditSwitch }

const changeBtnTextAndClass = () => {
  if (editBtn.innerText == "Edit Your Details / Log Out") {
    editBtn.innerText = "Exit Edit Mode";
    editBtn.classList.add("edit-mode-on");
  } else {
    editBtn.innerText = "Edit Your Details / Log Out";
    editBtn.classList.remove("edit-mode-on");
  }
}
