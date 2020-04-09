// contact.js
// This script checks a contact form submission for HTML and a valid email address.

// Function called when the form is submitted.
// Function validates the data and returns a Boolean.
function process() {
    'use strict';

    // Variable to represent validity:
    var okay = true;
    
    // Get form references:
    var email = document.getElementById('email');
    var comments = document.getElementById('comments');
    
    // Validate the email address:
    if (!email || !email.value 
    || (email.value.length < 6) 
    || (email.value.indexOf('@') == -1)) {
        okay = false;
        alert('Please enter a valid email address!');
    }

    // Validate the comments:
    if (!comments || !comments.value 
    || (comments.value.indexOf('<') != -1) ) {
        okay = false;
        alert('Please enter your comments, without any HTML!');
    }
        
    // Return the status:
    return okay;
    
} // End of process() function.

// Initial setup:
function init() {
    'use strict';
    document.getElementById('theForm').onsubmit = process;
} // End of init() function.
window.onload = init;