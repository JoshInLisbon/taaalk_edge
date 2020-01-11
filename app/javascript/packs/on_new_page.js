import { editSwitch } from "../components/edit_switch"
import { copyWithClick } from "../components/copy_with_click"
import { unsavedAlert, unsavedImageAlert } from "../components/unsaved_alert"
import { invitedLogin } from "../components/invited_login"
import { leaveTlk } from "../components/leave_tlk"

let mode = document.querySelector('#meta').content

if(mode == 'tlks-show-edit') {
  editSwitch();
  copyWithClick();
  unsavedAlert();
  leaveTlk();
  unsavedImageAlert();
}

if(mode == 'tlks-show-invited') {
  invitedLogin();
}

if(mode == 'tlks-show-spkr') {
  unsavedAlert();
  leaveTlk();
  unsavedImageAlert();
}
