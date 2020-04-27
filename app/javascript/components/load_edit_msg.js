var richTextAreas = document.querySelectorAll('.trix-content')
var keyupEvent = new Event('keyup');

const loadEditMsg = () => {
  console.log("hello")
  richTextAreas.forEach(rta => {
    // document.querySelector('.navbar').focus;
    setTimeout(function(){
      rta.dispatchEvent(keyupEvent);
    }, 50);
  });
}

export { loadEditMsg }
