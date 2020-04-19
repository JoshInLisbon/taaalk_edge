const inputs = document.querySelectorAll('input[type=text]');

const unsavedAlert = () => {
  inputs.forEach(input => {
    var startValue = input.value;
    input.addEventListener('keyup', (event) => {
      var id = input.getAttribute('target');
      var btn = document.querySelector(`#${id}`);
      var p = document.querySelector(`#p-${id}`);
      if (input.value !== startValue) {
        if (btn.value.match(/\(Done\)/)) {
          var startBtnValue = btn.value.match(/(.*)( \(Done\))/)[1]
          btn.value = startBtnValue
        }
        btn.classList.add('normal-unsaved');
        p.classList.remove('tlk-p-nochange');
        p.classList.add('tlk-p-unsaved');
        btn.addEventListener('click', (event) => {
          var startValue = input.value;
          btn.classList.remove('normal-unsaved');
          if (!btn.value.match(/\(Done\)/)) {
            btn.value += ' (Done)'
          }
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        });
      } else {
        if (!btn.classList.contains('radio-unsaved') && !btn.classList.contains('rta-unsaved') && !btn.classList.contains('image-unsaved')) {
          btn.classList.remove('normal-unsaved');
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        }
      }
    });
  });
}

export { unsavedAlert }


const rtaInputs = document.querySelectorAll('trix-editor');

const rtaUnsavedAlert = () => {
 rtaInputs.forEach(input => {
  var startValue = input.innerHTML;
  input.addEventListener('keyup', (event) => {
    var id = input.getAttribute('target');
    var btn = document.querySelector(`#${id}`);
    var p = document.querySelector(`#p-${id}`);
    var inputValueArray = input.value.split(/(<div>)(.*)/);
    var inputValue = `${inputValueArray[1]}<!--block-->${inputValueArray[2]}`
    if (inputValue !== startValue) {
      if (btn.value.match(/\(Done\)/)) {
        var startBtnValue = btn.value.match(/(.*)( \(Done\))/)[1]
        btn.value = startBtnValue
      }
      btn.classList.add('rta-unsaved');
      if(p) {
        p.classList.remove('tlk-p-nochange');
        p.classList.add('tlk-p-unsaved');
      }
      btn.addEventListener('click', (event) => {
        var startValue = input.value;
        if (!btn.value.match(/\(Done\)/)) {
          btn.value += ' (Done)'
        }
        btn.classList.remove('rta-unsaved');
        if(p) {
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        }
      });
    } else {
      if (!btn.classList.contains('radio-unsaved') && !btn.classList.contains('normal-unsaved') && !btn.classList.contains('image-unsaved')) {
        btn.classList.remove('rta-unsaved');
        if(p) {
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        }
      }
    }
  });
 })
}

export { rtaUnsavedAlert }

const imageInputs = document.querySelectorAll('input[type=file]');

const unsavedImageAlert = () => {
  imageInputs.forEach(input => {
    var startValue = input.value;
    input.addEventListener('change', (event) => {
      var id = input.getAttribute('target');
      var btn = document.querySelector(`#${id}`);
      var p = document.querySelector(`#p-${id}`);
      if (input.value !== startValue) {
        if (btn.value.match(/\(Done\)/)) {
          var startBtnValue = btn.value.match(/(.*)( \(Done\))/)[1]
          btn.value = startBtnValue
        }
        btn.classList.add('image-unsaved');
        p.classList.remove('tlk-p-nochange');
        p.classList.add('tlk-p-unsaved');
        btn.addEventListener('click', (event) => {
          if (!btn.value.match(/\(Done\)/)) {
            btn.value += ' (Done)'
          }
          var startValue = input.value;
          btn.classList.remove('image-unsaved');
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        });
      } else {
        if (!btn.classList.contains('radio-unsaved') && !btn.classList.contains('normal-unsaved') && !btn.classList.contains('rta-unsaved')) {
          btn.classList.remove('image-unsaved');
          p.classList.remove('tlk-p-unsaved');
          p.classList.add('tlk-p-nochange');
        }
      }
    });
  });
}

export { unsavedImageAlert }

const radioInputSections = document.querySelectorAll('.spkr-color-scroll');

const unsavedRadioAlert = () => {

  radioInputSections.forEach(section => {
    var id = section.getAttribute('target');
    var btn = document.querySelector(`#${id}`);
    var p = document.querySelector(`#p-${id}`);
    var sectionInputs = section.querySelectorAll('input[type=radio]')
    sectionInputs.forEach(input => {
      var startRadioValue = ""
      input.checked ? startRadioValue = input.value : startRadioValue = "";
      input.addEventListener('change', (event) => {
        if (input.value !== startRadioValue) {
          if (btn.value.match(/\(Done\)/)) {
            var startBtnValue = btn.value.match(/(.*)( \(Done\))/)[1]
            btn.value = startBtnValue
          }
          btn.classList.add('radio-unsaved');
          p.classList.remove('tlk-p-nochange');
          p.classList.add('tlk-p-unsaved');
          btn.addEventListener('click', (event) => {
            if (!btn.value.match(/\(Done\)/)) {
              btn.value += ' (Done)'
            }
            var startRadioValue = input.value;
            btn.classList.remove('radio-unsaved');
            p.classList.remove('tlk-p-unsaved');
            p.classList.add('tlk-p-nochange');
          });
        } else {
          if (!btn.classList.contains('normal-unsaved') && !btn.classList.contains('rta-unsaved') && !btn.classList.contains('image-unsaved')) {
            btn.classList.remove('radio-unsaved');
            p.classList.remove('tlk-p-unsaved');
            p.classList.add('tlk-p-nochange');
          }
        }
      });
    });
  });
}

export { unsavedRadioAlert }
