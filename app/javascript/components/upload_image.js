const uploadImage = () => {
  const uploaders = document.querySelectorAll('input[type="file"]');
  uploaders.forEach(uploader => {
    uploader.addEventListener('change', (event) => {
      const fileName = uploader.value.match(/[^\\]*\.(jpg|png|gif|tif)/i)[0];
      let target = uploader.getAttribute('target');
      const fileNameDiv = document.querySelector(`#${target}-file-name-div`);
      fileNameDiv.innerHTML = `✅ ${fileName} <br><strong>Press "Update" Button to Confirm</strong>`
    });
  });
};

export { uploadImage }
