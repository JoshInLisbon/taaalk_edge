const spkrEditBtns = document.querySelectorAll('.btn-spkr-edit');

const updateSpkrOnEdit = () => {
  spkrEditBtns.forEach(btn => {
    btn.addEventListener('click', (event) => {
      let nameInput = document.querySelector(`#name-${btn.id}`);
      let bioInput = document.querySelector(`#bio-${btn.id}`);
      let images = document.querySelectorAll(`.image-${btn.id}`)
      let names = document.querySelectorAll(`.name-${btn.id}`)
      let bio = document.querySelector(`.bio-${btn.id}`)
      names.forEach(name => {
        name.innerText = nameInput.value
      });
      images.forEach(image => {
        image.src = "url(<%= rails_blob_url(spkr.image) %>)"
      });
      bio.innerText = bioInput.value
    });
  });
}

export { updateSpkrOnEdit }
