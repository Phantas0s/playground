// Script 9.3- popup.js
// This script creates a popup window.

// Function called when the link is clicked.
function createPopup() {
    'use strict';
    
    // Create the window:
    var popup = window.open('popupB.html', 'PopUp', 'height=100,width=100,top=100,left=100,location=no,resizable=yes,scrollbars=yes');
    
    // Give the window focus if it's open:
    if ( (popup !== null) && !popup.closed) {
        popup.focus();
        return false; // Prevent the default behavior.
    }
    
} // End of createPopup() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';
    document.getElementById('link').onclick = createPopup;
};