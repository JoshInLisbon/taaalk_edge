let rtaForms = document.querySelectorAll('.rta')

const multiDraft = () => {
  rtaForms.forEach(rtaF => {
    let richTextArea = rtaF.querySelector('.trix-content');
    let fields = rtaF.getElementsByTagName('input');
    fields[1].value = richTextArea.innerHTML
    richTextArea.addEventListener('keyup', (event) => {
      fields[1].value = richTextArea.innerHTML
    });
  });
}

export { multiDraft }
