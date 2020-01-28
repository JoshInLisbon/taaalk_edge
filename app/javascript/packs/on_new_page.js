import { editSwitch } from "../components/edit_switch"
import { copyWithClick } from "../components/copy_with_click"
import { unsavedAlert, unsavedImageAlert } from "../components/unsaved_alert"
import { invitedLogin } from "../components/invited_login"
import { leaveTlk } from "../components/leave_tlk"
import { trixEditorOverrides } from "../components/trix-editor-overrides"
import { loadDraftMsg } from "../components/load_draft_msg"
import { multiDraft } from "../components/multi_draft"

let mode = document.querySelector('#meta').content

if(mode == 'tlks-show-edit') {
  editSwitch();
  copyWithClick();
  unsavedAlert();
  leaveTlk();
  unsavedImageAlert();
  trixEditorOverrides();
  loadDraftMsg();
  multiDraft();
}

if(mode == 'tlks-show-invited') {
  invitedLogin();
}

if(mode == 'tlks-show-spkr') {
  unsavedAlert();
  leaveTlk();
  unsavedImageAlert();
  trixEditorOverrides();
  loadDraftMsg();
  multiDraft();
}
