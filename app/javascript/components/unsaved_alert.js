const inputs = document.querySelectorAll('input[type=text]');

const unsavedAlert = () => {
  inputs.forEach(input => {
    let startValue = input.value
    input.addEventListener('keyup', (event) => {
      let id = input.getAttribute('target');
      let btn = document.querySelector(`#${id}`);
      let p = document.querySelector(`#p-${id}`);
      if (input.value !== startValue) {
        btn.classList.add('tlk-btn-unsaved');
        p.classList.remove('tlk-p-nochange');
        p.classList.add('tlk-p-unsaved');
        btn.addEventListener('click', (event) => {
          let startValue = input.value;
          btn.classList.remove('tlk-btn-unsaved');
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        });
      } else {
        btn.classList.remove('tlk-btn-unsaved');
        p.classList.remove('tlk-p-unsaved');
        p.classList.add('tlk-p-nochange');
      }
    });
  });
}

export { unsavedAlert }

const imageInputs = document.querySelectorAll('input[type=file]');

const unsavedImageAlert = () => {
  imageInputs.forEach(input => {
    let startValue = input.value
    input.addEventListener('change', (event) => {
      let id = input.getAttribute('target');
      let btn = document.querySelector(`#${id}`);
      let p = document.querySelector(`#p-${id}`);
      if (input.value !== startValue) {
        btn.classList.add('tlk-btn-unsaved');
        p.classList.remove('tlk-p-nochange');
        p.classList.add('tlk-p-unsaved');
        btn.addEventListener('click', (event) => {
          let startValue = input.value;
          btn.classList.remove('tlk-btn-unsaved');
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        });
      } else {
        btn.classList.remove('tlk-btn-unsaved');
        p.classList.remove('tlk-p-unsaved');
        p.classList.add('tlk-p-nochange');
      }
    });
  });
}

export { unsavedImageAlert }
