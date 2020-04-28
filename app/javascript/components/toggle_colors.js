var showMoreColorBtns = document.querySelectorAll('.spkr-color-show-more');

const toggleColorSpace = () => {
  showMoreColorBtns.forEach(btn => {
    var colorBtnTarget = btn.getAttribute('target')
    btn.addEventListener('click', (event) => {
      var colors = document.querySelector(`#${colorBtnTarget}`);
      colors.classList.toggle('spkr-color-scroll-short');
      if (btn.innerText == "See more colors...") {
        btn.innerText = "See less"
      } else {
        btn.innerText = "See more colors..."
      }
    });
  });
}

export { toggleColorSpace }
