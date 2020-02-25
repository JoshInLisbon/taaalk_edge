const scrollToPreview = () => {
  let previewBtns = document.querySelectorAll('.preview-msg')
  previewBtns.forEach(btn => {
    let targetId = btn.getAttribute('target');
    $(`#${btn.id}`).click(function() {
        $('html, body').animate({
            scrollTop: $(`#${targetId}`).offset().top
        }, 500);
    });
  })

}

export { scrollToPreview }
