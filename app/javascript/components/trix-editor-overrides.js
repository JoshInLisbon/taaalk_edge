const trixEditorOverrides = () => {
  window.addEventListener("trix-file-accept", function(event) {
    const maxFileSize = 2048 * 2048 // 4 MB
    let saveAlert = true
    if (event.file.size > maxFileSize) {
      event.preventDefault();
      alert("Only support attachment files upto size 4MB!");
      saveAlert = false
    }
    const acceptedTypes = ['image/jpeg', 'image/png']
    if (!acceptedTypes.includes(event.file.type)) {
      event.preventDefault()
      alert("Only support attachment of jpeg or png files")
      saveAlert = false
    }
    if (saveAlert) {
      console.log(saveAlert);
      console.log("uploaded :)");
      triggerTrixKeyupEvent();
    }
  });
}

export { trixEditorOverrides }

let msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");
let keyupEvent = new Event('keyup');

const triggerTrixKeyupEvent = () => {
  msgTrixInputDivs.forEach(div => {
    let msgTrixInput = div.querySelector("trix-editor");
    let msgTrixStore = div.querySelector('[name="msg[content]"]');
    setTimeout(function(){
      msgTrixInput.dispatchEvent(keyupEvent);
      // let startTrixValue = msgTrixStore.value;
      // setInterval(function(){ imageRemovalChecker(msgTrixStore, msgTrixInput, startTrixValue); startTrixValue = msgTrixStore.value; }, 1500)
    }, 200);
  });
}

// const imageRemovalChecker = (msgTrixStore, msgTrixInput, startTrixValue) => {
//   if (msgTrixStore.value !== startTrixValue) {
//     msgTrixInput.dispatchEvent(keyupEvent);
//   }
// }
