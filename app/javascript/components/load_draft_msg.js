var drafts = document.querySelectorAll('.tlk-draft');
var richTextAreas = document.querySelectorAll('.trix-content')
var keyupEvent = new Event('keyup');

const loadDraftMsg = (draftMsg) => {
  drafts.forEach(draft => {
    richTextAreas.forEach(rta => {
      let rtaTarget = rta.getAttribute('target')
      if(draft.id == `${rtaTarget}-draft`) {
        rta.innerHTML = draft.innerHTML;
        console.log(draft.innerHTML);
        console.log(rta.innerHTML);
      }
      document.querySelector('.navbar').focus;
      setTimeout(function(){
        rta.dispatchEvent(keyupEvent);
      }, 400);
    });
  });
}

export { loadDraftMsg }

