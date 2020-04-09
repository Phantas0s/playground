// epoch.js

// Call this function when the page has loaded
// and when mouseovers occur:
function updateDuration() {
    'use strict';

    // Get now:
    var now = new Date();

    // Create the message:
    var message = 'It has been ' + now.getTime();
    message += ' milliseconds since the epoch. (mouseover to update)';

    // Update the page:
    U.setText('output', message);
    
} // End of updateDuration() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';
    
    // Create the event listener:
    U.addEvent(U.$('output'), 'mouseover', updateDuration);
    
    // Call the function now:
    updateDuration();
    
};