// const changeBrToDiv = () => {
//   let msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");
//   msgTrixInputDivs.forEach(div => {
//     let msgTrixInput = div.querySelector("trix-editor");
//     let msgTrixStore = div.querySelector('[name="msg[content]"]');
//     let tlkBubbleStart = '<div class="tlk-bubble">';
//     let tlkBubbleEnd = '</div>';

//     let elemTarget = msgTrixInput.getAttribute('target');
//     // $(`[target="${elemTarget}"]`).val('');
//     $(`[target="${elemTarget}"]`).bind('input keyup', function(){

//       // pasted
//       let textBlock = []

//       let brMatchesBr = msgTrixStore.value.match(/(?<=<br>)([\s\S]*?)(?=<br>)/g);
//       let brMatchDiv = msgTrixStore.value.match(/<br>(?![\s\S]*<br>[\s\S]*$)([\s\S]*?)(?:<\/div>)/);
//       let blockMatchBr = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<br>)/);
//       let blockMatchDiv = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<\/div>)/);

//       // if(!blockMatchDiv || !blockMatchBr) {
//       //   textBlock.push(tlkBubbleStart, msgTrixInput.value, tlkBubbleEnd);
//       //   msgTrixStore.value = textBlock.join("");
//       // }
//       if(brMatchesBr) {
//         textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
//         brMatchesBr.forEach(match => {
//           if(match) {
//             textBlock.push(tlkBubbleStart, match, tlkBubbleEnd);
//           }
//         });
//         if(brMatchDiv[1]) {
//           textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
//         }
//       } else if(blockMatchBr) {
//         textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
//         if(brMatchDiv[1]) {
//           textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
//         }
//       } else if (blockMatchDiv) {
//         // alert(msgTrixInput.value);
//         textBlock.push(tlkBubbleStart, blockMatchDiv[1], tlkBubbleEnd);
//       }
//       // console.log(textBlock.join(""))
//       // msgTrixStore.value = textBlock.join("");

//       // let bubbles = document.querySelectorAll('.tlk-bubble')
//       // bubbles.forEach(bubble => {
//       //   bubble.innerText = msgTrixStore.value;
//       //   console.log(msgTrixStore.value);
//       // });
//     });

//     // msgTrixInput.addEventListener('keyup', (event) => {
//     //   // cut

//     // });

//   });
// }

export { changeBrToDiv }


const keyupEvent = new Event('keyup');

const changeBrToDiv = () => {
  // Finds all my 'areas' with Trix editors in my page
  let msgTrixInputDivs = document.querySelectorAll(".spkr-msg-form");
  msgTrixInputDivs.forEach(div => {
    let msgTrixInput = div.querySelector("trix-editor");
    let msgTrixStore = div.querySelector('[name="msg[content]"]');
    // set your own value here (e.g. if you want to use <p></p> etc...)
    let tlkBubbleStart = '<div class="tlk-bubble">';
    let tlkBubbleEnd = '</div>';


    // $(`[target="${elemTarget}"]`).bind('input keyup', function(){
    msgTrixInput.addEventListener('keyup', (event) => {

      let textBlock = []
      let completeVar = true

      // handles n > 3 line situations in the Trix input
      let brMatchesBr = msgTrixStore.value.match(/(?<=<br>)([\s\S]*?)(?=<br>)/g);
      // handles the last line if there are n > 1 lines
      let brMatchDiv = msgTrixStore.value.match(/<br>(?![\s\S]*<br>[\s\S]*$)([\s\S]*?)(?:<\/div>)/);
      // handles the first line if there are n > 1 lines
      let blockMatchBr = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<br>)/);
      // handles the first line if there is one line
      let blockMatchDiv = msgTrixStore.value.match(/(?:<!--block-->)([\s\S]*?)(?=<\/div>)/);

      if(!blockMatchBr || !blockMatchDiv || !brMatchDiv || !brMatchesBr) {
        textBlock.push(tlkBubbleStart, msgTrixInput.value, tlkBubbleEnd);
        completeVar = false;
      }

      // iterates through the different possibilities (i.e. if n > 3, if n > 1, then if n = 1) and updates the textBlock array accordingly
      if(completeVar) {
        if(brMatchesBr) {
          textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
          brMatchesBr.forEach(match => {
            if(match) {
              textBlock.push(tlkBubbleStart, match, tlkBubbleEnd);
            }
          });
          if(brMatchDiv[1]) {
            textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
          }
        } else if(blockMatchBr) {
          textBlock.push(tlkBubbleStart, blockMatchBr[1], tlkBubbleEnd);
          if(brMatchDiv[1]) {
            textBlock.push(tlkBubbleStart, brMatchDiv[1], tlkBubbleEnd);
          }
        } else if (blockMatchDiv) {
          textBlock.push(tlkBubbleStart, blockMatchDiv[1], tlkBubbleEnd);
        }
      }

      console.log(textBlock.join(""))
      // joins the textBlock array and sets it to the value of the msgTrixStore
      msgTrixStore.value = textBlock.join("");
      // alert(msgTrixInput.innerHTML);
    });


    // let formId = div.getAttribute('target');
    // $(`#${formId}`).submit( function(event) {
    //     var form = this;
    //     let finalInputValue = msgTrixInput.value
    //     msgTrixInput.value = finalInputValue + " ";
    //     msgTrixInput.dispatchEvent(keyupEvent);
    //     console.log("DID A THING");
    //     alert("HELO");
    //     var document = element.editor.getDocument()
    //     console.log(document.toString());

    //     event.preventDefault();

    //     setTimeout( function () {
    //         form.submit();
    //     }, 3000);
    // });

  });
}

// export { triggerKeyupOnSubmit }

// const triggerKeyupOnSubmit = () => {

// }


