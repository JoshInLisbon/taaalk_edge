import { toggleZone } from 'components/toggle_zone'

const leaveBtns = document.querySelectorAll('.leave-tlk');

const leaveTlk = () => {
  leaveBtns.forEach(btn => {
    let btnTarget = btn.getAttribute('target')
    btn.addEventListener('click', (event) => {
      let leaveLinks = document.querySelector(`#${btnTarget}`)
      toggleZone(leaveLinks);
    });
  });
}

export { leaveTlk }
