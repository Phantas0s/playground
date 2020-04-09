// today.js
// This script indicates the current date and time.

// Call this function when the page has loaded:
function init() {
    
    // Want to be strict:
    'use strict';

    // Create a Date object:
    var today = new Date();

    // Create a custom message:
    var message = 'Right now it is ' + today.toLocaleDateString();
    message += ' at ' + today.getHours() + ':' + today.getMinutes();
    
    // Get a reference to the paragraph:
    var output = document.getElementById('output');
    
    // Update the innerText or textContent property of the paragraph:
	if (output.textContent !== undefined) {
		output.textContent = message;
	} else {
		output.innerText = message;
	}
    
} // End of init() function.

window.onload = init;