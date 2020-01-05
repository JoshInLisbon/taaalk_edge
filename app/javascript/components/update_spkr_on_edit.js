const spkrEditBtns = document.querySelectorAll('.btn-spkr-edit');

const updateSpkrOnEdit = () => {
  spkrEditBtns.forEach(btn => {
    btn.addEventListener('click', (event) => {
      let nameInput = document.querySelector(`#name-${btn.id}`);
      let bioInput = document.querySelector(`#bio-${btn.id}`);
      let names = document.querySelectorAll(`.name-${btn.id}`)
      let bio = document.querySelector(`.bio-${btn.id}`)
      names.forEach(name => {
        name.innerText = nameInput.value
      });
      bio.innerText = bioInput.value
    });
  });
}

export { updateSpkrOnEdit }
