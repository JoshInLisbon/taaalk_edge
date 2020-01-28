let drafts = document.querySelectorAll('.tlk-draft');
let richTextAreas = document.querySelectorAll('.trix-content')

const loadDraftMsg = (draftMsg) => {
  drafts.forEach(draft => {
    richTextAreas.forEach(rta => {
      let rtaTarget = rta.getAttribute('target')
      if(draft.id == rtaTarget) {
        rta.innerHTML = draft.innerHTML;
      }
      document.querySelector('.navbar').focus;
    });
  });
}

export { loadDraftMsg }

