var keyupEvent = new Event('keyup');

var ev = document.createEvent('Event');
ev.initEvent('keypress');
ev.which = ev.keyCode = 13;

var richTextAreas = document.querySelectorAll('.trix-content')

const trixEditorOverrides = () => {
  richTextAreas.forEach(rta => {
    rta.addEventListener("trix-file-accept", function(event) {
      const maxFileSize = 6000 * 6000 // 4 MB
      let saveAlert = true
      if (event.file.size > maxFileSize) {
        event.preventDefault();
        alert("Only support attachment of images that are smaller than that!");
        saveAlert = false
      }
      const acceptedTypes = ['image/jpeg', 'image/png', 'image/jpg']
      if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault()
        alert("Only support attachment of jpg, jpeg or png files")
        saveAlert = false
      }
      if (saveAlert) {
        setTimeout(function(){
          var progress = document.querySelector('.attachment__progress');
            progress.style = "height: 100px; background: red;"
            console.log(progress.value);
            var uploadChecker = setInterval(function(){
              if(progress.value > 98) {
                triggerTrixKeyupEvent();
                clearInterval(uploadChecker);
                setTimeout(function(){
                  rta.dispatchEvent(keyupEvent);
                }, 750);
              }
            }, 50)
        }, 50);
      }
    });
  });
}

export { trixEditorOverrides }

var msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");

const triggerTrixKeyupEvent = () => {
  msgTrixInputDivs.forEach(div => {
    var msgTrixInput = div.querySelector("trix-editor");
    var msgTrixStore = div.querySelector('[name="msg[content]"]');
    setTimeout(function(){
      msgTrixInput.dispatchEvent(keyupEvent);
    }, 500);
  });
}

// const imageRemovalChecker = (msgTrixStore, msgTrixInput, startTrixValue) => {
//   if (msgTrixStore.value !== startTrixValue) {
//     msgTrixInput.dispatchEvent(keyupEvent);
//   }
// }
