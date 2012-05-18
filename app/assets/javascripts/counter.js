// This Javascript should be included with micro-posts form (_micropost_form.html.erb)
// It will automatically update the remaining characters count.

/*global document: false, console: false */ // Allow document and console in jslint

// Update the character counter and trim content if required
function trim_and_update(box, content_counter, limit) {
  "use strict";
  var chars_left, plural;
  chars_left = limit - box.value.length;
  if (chars_left < 0) {
    chars_left = 0;
    box.value = box.value.substring(0,limit);
    box.scrollTop = box.scrollHeight;
  }
  plural = (chars_left === 1)? '' : 's';
  content_counter.textContent = chars_left+' character'+plural+' left.';
}

// Display the character counter and setup event listeners to call 'trim_and_update'
function init_counter() {
  "use strict";
  var box, content_counter, CHAR_LIMIT = 140;
  content_counter = document.getElementById('micropost_content_counter');
  box = document.getElementById('micropost_content');
  if (content_counter && box) {
    content_counter.style.display = 'block';
    trim_and_update(box, content_counter, CHAR_LIMIT);
    box.onkeyup = function (){trim_and_update(box, content_counter, CHAR_LIMIT);};
    // Use on input if available, otherwise use mouse events and onchange
    if (typeof box.oninput !== 'undefined') {
      box.oninput = box.onkeyup;
    } else {
      box.onchange = box.onkeyup;
      box.onclick = box.onkeyup;
      box.onmouseup = box.onkeyup;
    }
    // Set maxLength on the text area if it's supported
    if (typeof box.maxLength !== 'undefined') {
      box.maxLength = CHAR_LIMIT;
    }
  }
}

window.onload = init_counter;