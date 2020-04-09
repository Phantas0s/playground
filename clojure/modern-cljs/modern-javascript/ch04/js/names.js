// Script 4.9 - names.js
// This script concatenates two strings together to format a name.


// Function called when the form is submitted.
// Function formats the text and returns false.
function formatNames() {
	'use strict';
	
	// For storing the formatted name:
	var formattedName;
    
    // Get a reference to the form values:
	var firstName = document.getElementById('firstName').value;
	var lastName = document.getElementById('lastName').value;
	
	// Create the formatted name:
	formattedName = lastName + ', ' + firstName;

	// Display the formatted name:
	document.getElementById('result').value = formattedName;
	
	// Return false to prevent submission:
	return false;
    
} // End of formatNames() function.

// Function called when the window has been loaded.
// Function needs to add an event listener to the form.
function init() {
	'use strict';
	document.getElementById('theForm').onsubmit = formatNames;
} // End of init() function.
window.onload = init;