import { editSwitch } from "../components/edit_switch"
import { copyWithClick } from "../components/copy_with_click"
import { unsavedAlert, unsavedImageAlert, rtaUnsavedAlert } from "../components/unsaved_alert"
import { invitedLogin } from "../components/invited_login"
import { leaveTlk } from "../components/leave_tlk"
import { trixEditorOverrides } from "../components/trix-editor-overrides"
import { loadDraftMsg } from "../components/load_draft_msg"
import { multiDraft } from "../components/multi_draft"
import { uploadImage } from "../components/upload_image"
import { changeBrToDiv } from "../components/trix_change_br_to_div"

let mode = document.querySelector('#meta').content

if(mode == 'tlks-show-edit') {
  editSwitch();
  copyWithClick();
  unsavedAlert();
  leaveTlk();
  unsavedImageAlert();
  rtaUnsavedAlert();
  trixEditorOverrides();
  loadDraftMsg();
  multiDraft();
  uploadImage();
  changeBrToDiv();
}

if(mode == 'tlks-show-invited') {
  invitedLogin();
}

if(mode == 'tlks-show-spkr') {
  editSwitch();
  unsavedAlert();
  rtaUnsavedAlert();
  leaveTlk();
  unsavedImageAlert();
  trixEditorOverrides();
  loadDraftMsg();
  multiDraft();
  changeBrToDiv();
  uploadImage();
}

if(mode == 'users-edit') {
  // uploadImage();
}
