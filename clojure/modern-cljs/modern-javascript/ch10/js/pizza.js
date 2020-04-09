// Script 10.5 - pizza.js
// This script creates a master checkbox.

// Function called when the checkbox's value changes.
// Function toggles all the other checkboxes.
function toggleCheckboxes() {
    'use strict';

	// Get the master checkbox's value:
	var status = document.getElementById('toggle').checked;
	
	// Get all the checkboxes:
	var boxes = document.querySelectorAll('input[type="checkbox"]');
	
	// Loop through the checkboxes, starting with the second:
	for (var i = 1, count = boxes.length; i < count; i++) {
		
		// Update the checked property:
		boxes[i].checked = status;
		
	} // End of FOR loop.
    
} // End of toggleCheckboxes() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';

    // Add an event handler to the master checkbox:
    document.getElementById('toggle').onchange = toggleCheckboxes;
    
};