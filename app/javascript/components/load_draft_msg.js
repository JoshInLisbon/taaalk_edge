const loadDraftMsg = (draftMsg) => {
  document.querySelector('trix-editor').innerHTML = draftMsg;
}

export { loadDraftMsg }
