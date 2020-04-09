// Script 8.6 - text.js #3

// Function called when a key is pressed in a textarea.
// Function limits the amount of text entered.
function limitText() {
    'use strict';
    
    // Get a reference to the form value:
    var comments = U.$('comments');

    // Count the characters:
    var count = comments.value.length;

    // Report the count:
    U.$('count').value = count;
    
    // Cut the overage:
    if (count > 100) {
        comments.value = comments.value.slice(0,100);
    }
    
} // End of limitText() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';
    U.addEvent(U.$('comments'), 'keyup', limitText);
    U.addEvent(U.$('comments'), 'change', limitText);
};