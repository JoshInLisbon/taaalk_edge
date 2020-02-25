const changeBrToDiv = () => {
  // Finds all my 'areas' with Trix editors in my page
  let msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");
  msgTrixInputDivs.forEach(div => {
    let msgTrixInput = div.querySelector("trix-editor");
    let msgTrixStore = div.querySelector('[name="msg[content]"]');
    // set your own value here (e.g. if you want to use <p></p> etc...)
    let tlkBubbleStart = '<div class="tlk-bubble-holder"><div class="tlk-bubble">';
    let tlkBubbleEnd = '</div></div>';

    let msgTrixPreview = div.querySelector(".msg-preview");

    let elemTarget = msgTrixInput.getAttribute('target');
    $(`[target="${elemTarget}"]`).bind('input keyup', function() {
      // setTimeout handles auto complete on mobile. Trix sets the value of msgTrixStore after 'input' is triggered
      // so while 'input' is triggered on mobile autocomplete, it is overriden by Trix editors 'natural processes'
      // the setTimeout delay means our function wins the battle.
      setTimeout(function() {
        let skipDivs = false;
        let textBlock = [];
        // handle copy and paste (where multiple divs are pasted into the editor)
        let msgTrixInputDivs = msgTrixInput.querySelectorAll("div, pre, h1, blockquote, ul, ol");

        // handles first word on mobile where no divs are in the Trix editor (reason unknown)
        if(!msgTrixInputDivs[0]) {
          textBlock.push(tlkBubbleStart, msgTrixInput.innerHTML, tlkBubbleEnd);
          skipDivs = true;
          let tlkBubbleText = textBlock.flat(Infinity).join("").replace(/<div class="tlk-bubble"><\/div>/g, "");
          // joins the textBlock array and sets it to the value of the msgTrixStore
          msgTrixPreview.innerHTML = tlkBubbleText;
          msgTrixStore.value = tlkBubbleText;
          // msgTrixStore.value = textBlock.flat(Infinity).join("");

        }

        if(!skipDivs) {
          msgTrixInputDivs.forEach(mtiDiv => {
            // handles code
            let pre = mtiDiv.outerHTML.match(/<pre>[\s\S]*?<\/pre>/)
            // handles blockquote
            let blockquote = mtiDiv.outerHTML.match(/<blockquote>[\s\S]*?<\/blockquote>/);
            // handles ul
            let ul = mtiDiv.outerHTML.match(/<ul>[\s\S]*?<\/ul>/)
            // handles ol
            let ol = mtiDiv.outerHTML.match(/<ol>[\s\S]*?<\/ol>/)
            // handles h1
            let h1 = mtiDiv.outerHTML.match(/<h1>[\s\S]*?<\/h1>/)
            // handles n > 3 line situations in the Trix input
            let brMatchesBr = mtiDiv.outerHTML.match(/(?<=<br>)([\s\S]*?)(?=<br>)/g);
            // handles the last line if there are n > 1 lines
            let brMatchDiv = mtiDiv.outerHTML.match(/<br>(?![\s\S]*<br>[\s\S]*$)([\s\S]*?)(?:<\/div>)/);
            // handles the first line if there are n > 1 lines
            let blockMatchBr = mtiDiv.outerHTML.match(/(?:<!--block-->)([\s\S]*?)(?=<br>)/);
            // handles the first line if there is one line
            let blockMatchDiv = mtiDiv.outerHTML.match(/(?:<!--block-->)([\s\S]*?)(?=<\/div>)/);

            // iterates through the different possibilities (i.e. if pre, if ul, n > 3, if n > 1, then if n = 1) and updates the textBlock array accordingly
            if(pre) {
              textBlock.push(tlkBubbleStart, pre[0], tlkBubbleEnd);
            } else if(blockquote) {
              textBlock.push(tlkBubbleStart, blockquote[0], tlkBubbleEnd);
            } else if(ul) {
              textBlock.push(tlkBubbleStart, ul[0], tlkBubbleEnd);
            } else if(ol) {
              textBlock.push(tlkBubbleStart, ol[0], tlkBubbleEnd);
            } else if(h1) {
              textBlock.push(tlkBubbleStart, h1[0], tlkBubbleEnd);
            } else if(brMatchesBr) {
              textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
              brMatchesBr.forEach(match => {
                if(match) {
                  textBlock.push(tlkBubbleStart, match, tlkBubbleEnd);
                }
              });
              if(brMatchDiv) {
                textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
              }
            } else if(blockMatchBr) {
              textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
              if(brMatchDiv) {
                textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
              }
            } else if (blockMatchDiv) {
              textBlock.push(tlkBubbleStart, blockMatchDiv[1], tlkBubbleEnd);
            }
            // see your result in the console
            // console.log(textBlock.flat(Infinity).join(""));
            let tlkBubbleText = textBlock.flat(Infinity).join("").replace(/<div class="tlk-bubble"><\/div>/g, "");
            // joins the textBlock array and sets it to the value of the msgTrixStore
            msgTrixPreview.innerHTML = tlkBubbleText;
            msgTrixStore.value = tlkBubbleText;
          });
        }

        if (msgTrixInput.value == "" || msgTrixInput.value == '<div class="tlk-bubble-holder"></div>'){
          msgTrixPreview.innerHTML = '<p>Your message preview will appear here.</p>'
        }
      }, 250);
    });
  });
}

export { changeBrToDiv }

// Non mobile line 12:
// msgTrixInput.addEventListener('keyup', (event) => {


