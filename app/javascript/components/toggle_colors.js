var showMoreColorBtns = document.querySelectorAll('.spkr-color-show-more');

const toggleColorSpace = () => {
  showMoreColorBtns.forEach(btn => {
    var colorBtnTarget = btn.getAttribute('target')
    btn.addEventListener('click', (event) => {
      var colors = document.querySelector(`#${colorBtnTarget}`);
      colors.classList.toggle('spkr-color-scroll-short');
      if (btn.innerText == "Show more colors...") {
        btn.innerText = "Show less"
      } else {
        btn.innerText = "Show more colors..."
      }
    });
  });
}

export { toggleColorSpace }
