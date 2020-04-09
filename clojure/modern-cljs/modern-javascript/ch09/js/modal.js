// Script 9.10 - modal.js

// Function called to open the window:
function openModal() {
    'use strict';

    // Add a click handler to the close modal button:
    document.getElementById('closeModal').onclick = closeModal;
    
    // Make the modal DIV visible:
    document.getElementById('modal').style.display = 'inline-block';

    // Remove the click handler on the open modal button:
    document.getElementById('openModal').onclick = null;
    
} // End of openModal() function.

// Function called to close the window:
function closeModal() {
    'use strict';

    // Add a click handler to the open modal button:
    document.getElementById('openModal').onclick = openModal;

    // Make the modal DIV invisible:
    document.getElementById('modal').style.display = 'none';

    // Remove the click handler on the close modal button:
    document.getElementById('closeModal').onclick = null;
    
} // End of closeModal() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';

    // Add a click handler to the open modal button:
    document.getElementById('openModal').onclick = openModal;

};