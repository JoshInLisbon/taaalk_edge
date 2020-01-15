const trixEditorOverrides = () => {
  window.addEventListener("trix-file-accept", function(event) {
    const maxFileSize = 2048 * 2048 // 4 MB
    if (event.file.size > maxFileSize) {
      event.preventDefault();
      alert("Only support attachment files upto size 4MB!");
    }
  });
}

export { trixEditorOverrides }
