import { editSwitch } from "../components/edit_switch"
import { updateSpkrOnEdit } from "../components/update_spkr_from_tlk"

let editMode = document.querySelector('#meta').content

if(editMode == 'tlks-show-edit') {
  editSwitch();
  updateSpkrOnEdit();
}
