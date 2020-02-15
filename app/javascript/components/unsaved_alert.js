const inputs = document.querySelectorAll('input[type=text]');

const unsavedAlert = () => {
  inputs.forEach(input => {
    let startValue = input.value;
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


const rtaInputs = document.querySelectorAll('trix-editor');

const rtaUnsavedAlert = () => {
 rtaInputs.forEach(input => {
  let startValue = input.innerHTML;
  input.addEventListener('keyup', (event) => {
    let id = input.getAttribute('target');
    let btn = document.querySelector(`#${id}`);
    let p = document.querySelector(`#p-${id}`);
    let inputValueArray = input.value.split(/(<div>)(.*)/);
    let inputValue = `${inputValueArray[1]}<!--block-->${inputValueArray[2]}`
    if (inputValue !== startValue) {
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
      console.log("start again!")
      btn.classList.remove('tlk-btn-unsaved');
      p.classList.remove('tlk-p-unsaved');
      p.classList.add('tlk-p-nochange');
    }
  });
 })
}

export { rtaUnsavedAlert }

const imageInputs = document.querySelectorAll('input[type=file]');

const unsavedImageAlert = () => {
  imageInputs.forEach(input => {
    let startValue = input.value;
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
