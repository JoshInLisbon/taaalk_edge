import { toggleZone } from 'components/toggle_zone'

// const loginLink = document.querySelector('#tlk-invited-login');
// const signupLink = document.querySelector('#tlk-invited-signup');
// const loginZone = document.querySelector('.tlk-login');
// const signupZone = document.querySelector('.tlk-signup');
// const loginNote = document.querySelector('#tlk-invited-note-login');
// const signupNote = document.querySelector('#tlk-invited-note-signup');

// const invitedLogin = () => {
//   [loginLink, signupLink].forEach(link => {
//     link.addEventListener('click', (event) => {
//       toggleZone(loginZone);
//       toggleZone(signupZone);
//       toggleZone(loginNote);
//       toggleZone(signupNote);
//     });
//   });
// }

// export { invitedLogin }

const loginLinks = document.querySelectorAll('.tlk-invited-login');
const signupLinks = document.querySelectorAll('.tlk-invited-signup');
const loginZone = document.querySelector('.tlk-login');
const signupZone = document.querySelector('.tlk-signup');
const loginNote = document.querySelector('#tlk-invited-note-login');
const signupNote = document.querySelector('#tlk-invited-note-signup');

console.log([loginLinks, signupLinks]);

const links = [loginLinks, signupLinks].flat();
console.log(links);

const invitedLogin = () => {
  loginLinks.forEach(link => {
    link.addEventListener('click', (event) => {
      toggleZone(loginZone);
      toggleZone(signupZone);
      toggleZone(loginNote);
      toggleZone(signupNote);
    });
  });

  signupLinks.forEach(link => {
    link.addEventListener('click', (event) => {
      toggleZone(loginZone);
      toggleZone(signupZone);
      toggleZone(loginNote);
      toggleZone(signupNote);
    });
  });
}

export { invitedLogin }
