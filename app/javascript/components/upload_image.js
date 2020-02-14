const uploadImage = () => {
  console.log("alive!");
  const uploaders = document.querySelectorAll('input[type="file"]');
  uploaders.forEach(uploader => {
    uploader.addEventListener('change', (event) => {
      const fileName = uploader.value.match(/[^\\]*\.(jpg|png|gif|tif)/i)[0];
      let target = uploader.getAttribute('target');
      const fileNameDiv = document.querySelector(`#${target}-file-name-div`);
      fileNameDiv.innerHTML = `✅ ${fileName}`

      // const fileNameDiv = document.querySelector('.file-name-div');
    });
  });
  // const


  // const upload = document.querySelector('#cocktail_photo');
  // upload.addEventListener('change', (event) => {
  //   const fileName = upload.value.match(/[^\\]*\.(jpg|png|gif|tif)/i)[0];
  //   const fileNameDiv = document.querySelector('#fileNameDiv');
  //   fileNameDiv.innerHTML = `✅ ${fileName}`
  // });
};

export { uploadImage }
