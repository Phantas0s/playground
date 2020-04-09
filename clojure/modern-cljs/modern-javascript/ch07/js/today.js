// today.js #2
// This script indicates the current date and time.

// This function is used to update the text of an HTML element.
// The function takes two arguments: the element's ID and the text message.
function setText(elementId, message) {
    'use strict';
    
    if ( (typeof elementId == 'string')
    && (typeof message == 'string') ) {
    
        // Get a reference to the paragraph:
        var output = document.getElementById(elementId);
    
        // Update the innerText or textContent property of the paragraph:
		if (output.textContent !== undefined) {
			output.textContent = message;
		} else {
			output.innerText = message;
		}
    
    } // End of main IF.

} // End of setText() function.

// Call this function when the page has loaded:
function init() {
    'use strict';
    var today = new Date();
    var message = 'Right now it is ' + today.toLocaleDateString();
    message += ' at ' + today.getHours() + ':' + today.getMinutes();

    // Update the page:
    setText('output', message);
    
} // End of init() function.
window.onload = init;