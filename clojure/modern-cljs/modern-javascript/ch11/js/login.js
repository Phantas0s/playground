// Script 11.x - login.js #2

// Function called when the form is submitted.
// Function validates the form data and returns a Boolean value.
function validateForm() {
    'use strict';
    
    // Get references to the form elements:
    var email = document.getElementById('email');
    var password = document.getElementById('password');

    // Validate!
	if ( (email.value.length > 0) && (password.value.length > 0) ) {

	// Perform an Ajax request:
	var ajax = getXMLHttpRequestObject();
ajax.onreadystatechange = function() {
if (ajax.readyState == 4) {

// Check the status code:
if ( (ajax.status >= 200 && ajax.status < 300) 
|| (ajax.status == 304) ) {

if (ajax.responseText == 'VALID') {
alert('You are now logged in!');
} else {
alert('The submitted values do not match those on file!');
}

} else {
document.getElementById('theForm').submit();
}
}

};
ajax.open('POST', 'resources/login.php', true);
ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
var data = 'email=' + encodeURIComponent(email.value) + '&password=' + encodeURIComponent(password.value);
ajax.send(data);	
	
        return false;

    } else {
        alert('Please complete the form!');
        return false;
    }
    
} // End of validateForm() function.

// Function called when the window has been loaded.
// Function needs to add an event listener to the form.
function init() {
    'use strict';
    
    // Confirm that document.getElementById() can be used:
    if (document && document.getElementById) {
        var loginForm = document.getElementById('loginForm');
        loginForm.onsubmit = validateForm;
    }

} // End of init() function.

// Assign an event listener to the window's load event:
window.onload = init;