// Script 9.5- popups.js
// This script creates a popup window on every link.

// Function called when the link is clicked.
function createPopup(e) {
    'use strict';
    
    // Get the event object:
    if (typeof e == 'undefined') var e = window.event;

    // Get the event target:
    var target = e.target || e.srcElement;

    // Create the window:
    var popup = window.open(target.href, 'PopUp', 'height=100,width=100,top=100,left=100,location=no,resizable=yes,scrollbars=yes');
    
    // Give the window focus if it's open:
    if ( (popup !== null) && !popup.closed) {
        popup.focus();
        return false; // Prevent the default behavior.
    } else { // Allow the default behavior.
        return true;
    }
    
} // End of createPopup() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';
    
    // Add the click handler to each link:
    for (var i = 0, count = document.links.length; i < count; i++) {
        document.links[i].onclick = createPopup;
    } // End of for loop.

}; // End of onload function.