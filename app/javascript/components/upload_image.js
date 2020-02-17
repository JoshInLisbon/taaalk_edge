const uploadImage = () => {
  console.log("alive!");
  const uploaders = document.querySelectorAll('input[type="file"]');
  uploaders.forEach(uploader => {
    uploader.addEventListener('change', (event) => {
      const fileName = uploader.value.match(/[^\\]*\.(jpg|png|gif|tif)/i)[0];
      let target = uploader.getAttribute('target');
      const fileNameDiv = document.querySelector(`#${target}-file-name-div`);
      fileNameDiv.innerHTML = `✅ ${fileName}`
    });
  });
};

export { uploadImage }
