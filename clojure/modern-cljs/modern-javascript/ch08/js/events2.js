// Script 8.x - events.js #2 with prevention

// Function called when events occur.
// Function reports the event type and target.
function reportEvent(e) {
    'use strict';

    // Get the event object:
	if (typeof e == 'undefined') e = window.event;

	// Get the event target:
	var target = e.target || e.srcElement;
    
    // Establish the output message:
    var msg = target.nodeName + ': ' + e.type + '\n';
    
    // Add the output to the textarea:
    U.$('output').value += msg;
    
} // End of reportEvent() function.

// This function is called when the form is submitted.
// It adds and removes event handlers
// and returns false to prevent submission.
function setHandlers() {
    'use strict';

    // List of possible events:
    var events = ['mouseover', 'mouseout', 'click', 'keypress', 'blur'];
    
    // Add or remove event handlers accordingly:
	for (var i = 0, count = events.length; i < count; i++) {
	    var checkbox = U.$(events[i]); // Get the element.
		if (checkbox.checked) { // Is it checked?
		    U.addEvent(document, events[i], reportEvent);
		} else {
		    U.removeEvent(document, events[i], reportEvent);
		}
    } // End of FOR loop.
    
    // Clear the output textarea:
    U.$('output').value = '';
    
    // Return false to prevent submission:
    return false;
    
} // End of setHandlers() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';
	U.addEvent(U.$('theForm'), 'submit', setHandlers);
};