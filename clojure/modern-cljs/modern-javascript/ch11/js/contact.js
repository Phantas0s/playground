// # contact.js
// This script performs an Ajax request for a contact form.

// Function that handles the Ajax response.
function handleAjaxResponse(e) {
    'use strict';

    // Get the event object:
	if (typeof e == 'undefined') var e = window.event;

	// Get the event target:
	var ajax = e.target || e.srcElement;

// Check the readyState property:
if (ajax.readyState == 4) {
	
	// Check the status code:
    if ( (ajax.status >= 200 && ajax.status < 300) 
    || (ajax.status == 304) ) {
	
		// Update the page:
		document.getElementById('contactForm').innerHTML = ajax.responseText;
			
	    } else { // Status error!
			document.getElementById('theForm').submit();
	    }
	
		ajax = null;
				
	} // End of readyState IF.
	
} // End of handleAjaxResponse() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';

	// Create the Ajax object:
	var ajax = getXMLHttpRequestObject();
	
	// Function to be called when the readyState changes:
	ajax.onreadystatechange = handleAjaxResponse;

    // Add an event handler to the form's submission:
    document.getElementById('theForm').onsubmit = function() {
	
		// Create the data:
		var fields = ['name', 'email', 'comments'];
		var data = []; // Empty array.
		for (var i = 0, count = fields.length; i < count; i++) {
			data.push(encodeURIComponent(fields[i]) + '=' + encodeURIComponent(document.getElementById(fields[i]).value));
		}
		
		// Open the request:
		ajax.open('POST', 'resources/contact.php', true);
		ajax.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

		// Send the request:
		ajax.send(data.join('&'));
		
		return false;
		
	}; // End of onsubmit function.
    
}; // End of onload function.