import { editSwitch } from "../components/edit_switch"
import { updateSpkrOnEdit } from "../components/update_spkr_on_edit"
import { copyWithClick } from "../components/copy_with_click"
import { unsavedAlert } from "../components/unsaved_alert"
import { invitedLogin } from "../components/invited_login"

let mode = document.querySelector('#meta').content

if(mode == 'tlks-show-edit') {
  editSwitch();
  updateSpkrOnEdit();
  copyWithClick();
  unsavedAlert();
}

if(mode == 'tlks-show-invited') {
  invitedLogin();
}

if(mode == 'tlks-show-spkr') {
  unsavedAlert();
}
