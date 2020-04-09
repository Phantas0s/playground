// fader.js
// This script creates a fader.

// Function does all the work:
window.onload = function() {
	'use strict';
	
	// Get the target:
	var target = document.getElementById('target');
	
	// Set the initial opacity to 100:
	var opacity = 100;

	// Create the interval fader:
	var fader = setInterval(function() { 

		// Decrease the opacity:
		opacity -= 10;

		// As long as the opacity is positive, do the following:
		if (opacity >= 0) {
	
			// For some browsers:
			if (typeof target.style.opacity == 'string') {
				target.style.opacity = (opacity/100);
			} else { // For others:
				target.style.filter = 'alpha(opacity=' + opacity + ')';
			}
		} else {
			clearInterval(fader);
		}
		
	}, 100); // End of setInterval().
	
}; // End of onload anonymous function.