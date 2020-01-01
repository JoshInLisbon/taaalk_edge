import { editSwitch } from "../components/edit_switch"
import { updateSpkrOnEdit } from "../components/update_spkr_on_edit"
import { copyWithClick } from "../components/copy_with_click"
import { unsavedAlert } from "../components/unsaved_alert"

let editMode = document.querySelector('#meta').content

if(editMode == 'tlks-show-edit') {
  editSwitch();
  updateSpkrOnEdit();
  copyWithClick();
  unsavedAlert();
}
