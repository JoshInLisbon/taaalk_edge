const indexInfoPivot = () => {
  let hmmmBtn = document.querySelector('#index-what-btn');
  let indexBackground = document.querySelector('#index-background-color');
  let indexTlk = document.querySelector('#tlk-intro-container');
  let topWhiteSplit = document.querySelector('#index-top-small-blue-split');
  let indexBorderBtmContainer = document.querySelector('.index-border-btm-container');
  hmmmBtn.addEventListener('click', (event) => {
    if (hmmmBtn.innerHTML == 'Learn More') {
      hmmmBtn.classList.add('got-it-mode-on');
      hmmmBtn.classList.remove('edit-mode-on');
      hmmmBtn.innerHTML = 'Got It';
      // indexBorderBtmContainer.style = "border-bottom: 40px solid #f81016;"
    } else {
      hmmmBtn.classList.add('edit-mode-on');
      hmmmBtn.classList.remove('got-it-mode-on');
      hmmmBtn.innerHTML = 'Learn More';
      // indexBorderBtmContainer.style = "border-bottom: 40px solid #07d755;"
    }
    if (indexTlk.classList.contains("index-hide-intro")) {
      indexTlk.classList.remove("index-hide-intro");
      let bubble390 = document.querySelector('#bubble-390');
      if(bubble390.clientHeight > 60) {
        bubble390.style = "max-width: 264px;";
      }
      indexBackground.classList.add("index-background-color-big");
      indexBackground.classList.remove("index-background-color-small");
    } else {
      indexTlk.classList.add("index-hide-intro");
      indexBackground.classList.add("index-background-color-small");
      indexBackground.classList.remove("index-background-color-big");
    }

    // hmmmBtn.classList.add('index-hide-intro');
  });
}

export { indexInfoPivot }
// let tlkIntroContainer = document.querySelector('.tlk-intro-container');
// tlkIntroContainer.style = "display: none;"
