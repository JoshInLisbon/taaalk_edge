import { editSwitch } from "../components/edit_switch"

let editMode = document.querySelector('#meta').content

if(editMode == 'tlks-show-edit') {
  editSwitch();
  console.log('edit mode present!')
}
