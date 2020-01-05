import { toggleZone } from 'components/toggle_zone'

const leave = document.querySelector('#leave-tlk');
const leaveLinks = document.querySelector('#leave-tlk-links');

const leaveTlk = () => {
  leave.addEventListener('click', (event) => {
    toggleZone(leaveLinks);
  });
}

export { leaveTlk }
