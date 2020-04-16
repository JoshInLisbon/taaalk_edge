const copyBtns = document.querySelectorAll('.copy-with-click');

const copyWithClick = () => {
  copyBtns.forEach(btn => {
    btn.addEventListener('click', (event) => {
      let id = btn.getAttribute('target');
      selectText(id);
      document.execCommand('copy');
      // btn.innerText = 'copied';
    btn.style = 'color: #2c2c57;';
    });
  });
}

export { copyWithClick }

const selectText = (id) => {
  if (document.selection) { // IE
      let range = document.body.createTextRange();
      range.moveToElementText(document.getElementById(id));
      range.select();
  } else if (window.getSelection) {
      let range = document.createRange();
      range.selectNode(document.getElementById(id));
      window.getSelection().removeAllRanges();
      window.getSelection().addRange(range);
  }
}
