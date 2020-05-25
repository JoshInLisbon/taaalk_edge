var autoTweetSections = document.querySelectorAll('.auto-tweet');

const autoTweet = () => {
  autoTweetSections.forEach(ats => {

    var checkbox = ats.querySelector('.auto-tweet-checkbox');
    checkbox.addEventListener('click', (event) => {
      ats.classList.toggle('auto-tweet-on');
      ats.classList.toggle('auto-tweet-off');
      var atTarget = ats.id
      if (ats.classList.contains('auto-tweet-on')) {
        console.log("tweet on!");
        var spkrAtBoolean = document.querySelector(`[target="${atTarget}"]`);
        spkrAtBoolean.value = true;
        var msgPubBtn = ats.querySelector(`[target="submit-${atTarget}"]`);
        var tweet = ats.querySelector('.example-tweet').innerText.replace(/ /g,"%20").replace(/&/,"%26");
        msgPubBtn.addEventListener('click', function msgTweet(event) {
          window.open(`https://twitter.com/intent/tweet?original_referer=yoururl.com&source=tweetbutton&text=${tweet}`);
        });
      }
      if (ats.classList.contains('auto-tweet-off')) {
        console.log("tweet off!");
        var spkrAtBoolean = document.querySelector(`[target="${atTarget}"]`);
        spkrAtBoolean.value = false;
        var msgPubBtn = ats.querySelector(`[target="submit-${atTarget}"]`);
        var old_element = msgPubBtn
        var new_element = old_element.cloneNode(true);
        old_element.parentNode.replaceChild(new_element, old_element);
      }
    });
    var atTarget = ats.id
    if (ats.classList.contains('auto-tweet-on')) {
      console.log("tweet on!");
      // var spkrAtBoolean = document.querySelector(`[target="${atTarget}"]`);
      // spkrAtBoolean.value = true;
      var msgPubBtn = ats.querySelector(`[target="submit-${atTarget}"]`);
      var tweet = ats.querySelector('.example-tweet').innerText.replace(/ /g,"%20").replace(/&/,"%26");
      msgPubBtn.addEventListener('click', (event) => {
        window.open(`https://twitter.com/intent/tweet?original_referer=yoururl.com&source=tweetbutton&text=${tweet}`);
      });
    }
    if (ats.classList.contains('auto-tweet-off')) {
      console.log("tweet off!");
      // var spkrAtBoolean = document.querySelector(`[target="${atTarget}"]`);
      // spkrAtBoolean.value = false;
      // var msgPubBtn = ats.querySelector(`[target="submit-${atTarget}"]`);
      // msgPubBtn.removeEventListener('click', msgTweet);
    }
  });
}

export { autoTweet }
