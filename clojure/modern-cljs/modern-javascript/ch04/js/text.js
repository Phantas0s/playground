// Script 4.7 - text.js
// This script limits the amount of text that can be entered into a textarea.

// Function called when the form is submitted.
// Function limits the text and returns false.
function limitText() {
	'use strict';
	
	// For storing the limited text:
	var limitedText;
    
    // Get a reference to the form value:
	var originalText = document.getElementById('comments').value;

	// Find the last space before 100 characters:
	var lastSpace = originalText.lastIndexOf(' ', 100);
	
	// Trim the text to that spot:
	limitedText = originalText.slice(0, lastSpace);
	
	// Display the number of characters submitted:
	document.getElementById('count').value = originalText.length;

	// Display the limitedText:
	document.getElementById('result').value = limitedText;
	
	// Return false to prevent submission:
	return false;
    
} // End of limitText() function.

// Function called when the window has been loaded.
// Function needs to add an event listener to the form.
function init() {
	'use strict';
	document.getElementById('theForm').onsubmit = limitText;
} // End of init() function.
window.onload = init;
