// Script 4.5 - sphere.js
// This script calculates the volume of a sphere.

// Function called when the form is submitted.
// Function performs the calculation and returns false.
function calculate() {
	'use strict';
	
	// For storing the volume:
	var volume;
    
    // Get a reference to the form value:
    var radius = document.getElementById('radius').value;

	// Make sure it's positive:
	radius = Math.abs(radius);
	
	// Perform the calculation:
	volume = (4/3) * Math.PI * Math.pow(radius, 3);

	// Format the volume:
	volume = volume.toFixed(4);
	
	// Display the volume:
	document.getElementById('volume').value = volume;
	
	// Return false to prevent submission:
	return false;
    
} // End of calculate() function.

// Function called when the window has been loaded.
// Function needs to add an event listener to the form.
function init() {
	'use strict';
	document.getElementById('theForm').onsubmit = calculate;
} // End of init() function.
window.onload = init;