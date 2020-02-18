const changeBrToP = () => {
  let msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");
  msgTrixInputDivs.forEach(div => {
    let msgTrixInput = div.querySelector("trix-editor");
    let msgTrixStore = div.querySelector('[name="msg[content]"]');
    let tlkBubbleStart = '<div class="tlk-bubble">';
    let tlkBubbleEnd = '</div>';
    console.log(msgTrixStore);
    msgTrixInput.addEventListener('keyup', (event) => {
      let textBlock = [tlkBubbleStart]

      let brMatchesBr = msgTrixStore.value.match(/(?<=<br>)([\s\S]*?)(?=<br>)/g);
      let brMatchDiv = msgTrixStore.value.match(/<br>(?![\s\S]*<br>[\s\S]*$)([\s\S]*?)(?:<\/div>)/);
      let blockMatchBr = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<br>)/);
      let blockMatchDiv = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<\/div>)/);


      if(brMatchesBr) {
        textBlock.push(blockMatchBr[1], tlkBubbleEnd);
        brMatchesBr.forEach(match => {
          if(match) {
            textBlock.push(tlkBubbleStart, match, tlkBubbleEnd);
          }
        });
        if(brMatchDiv[1]) {
          textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
        }
      } else if(blockMatchBr) {
        textBlock.push(blockMatchBr[1], tlkBubbleEnd);
        if(brMatchDiv[1]) {
          textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
        }
      } else if (blockMatchDiv) {
        textBlock.push(blockMatchDiv[1], tlkBubbleEnd);
      }

      console.log(textBlock);










      // if(blockMatchDiv) {
      //   console.log("blockMatchDiv:");
      //   console.log(blockMatchDiv[1]);
      // }
      // // console.log(blockMatchDiv[1]);


      // if(blockMatchBr) {
      //   console.log("blockMatchBr:");
      //   console.log(blockMatchBr[1]);
      // } else {
      //   console.log("blockMatchBr does not exist");
      // }


      // if(blockMatchBr) {
      //   console.log("NP!")
      //   textBlock.push(blockMatchBr[1], '</div>');
      // } else {
      //   console.log("HIHI")
      //   textBlock.push(blockMatchDiv[1], '</div>');
      // }

      // console.log(textBlock);


      // console.log("brMatchBr:");
      // if(brMatchesBr) {
      //   brMatchesBr.forEach(match => {
      //     console.log(match);
      //   });
      // }



      // if(brMatchDiv) {
      //   console.log("brMatchDiv:");
      //   console.log(brMatchDiv[1]);
      // }







    });



  });
}

export { changeBrToP }

// /<!--block-->([^<br>]*)/
// /<br>([^<br>]*)/

// (?:<br>)([\s\S]*?)(?=<br>)
// (?:<!--block-->)([\s\S]*?)(?=<br>)
// <br>(?![\s\S]*<br>[\s\S]*$)([\s\S]*?)(?:<\/div>)
// (?:<!--block-->)([\s\S]*?)(?=<\/div>)
