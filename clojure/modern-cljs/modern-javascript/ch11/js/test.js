// Script 11.3 - test.js
// This script performs an Ajax request and updates the page with the response.

// Establish functionality on window load:
window.onload = function() {
    'use strict';

	// Create the Ajax object:
	var ajax = getXMLHttpRequestObject();
	
	// Function to be called when the readyState changes:
	ajax.onreadystatechange = function() {

		// Check the readyState property:
		if (ajax.readyState == 4) {
			
			// Check the status code:
		    if ( (ajax.status >= 200 && ajax.status < 300) 
		    || (ajax.status == 304) ) {
			
				// Update the page:
				// Text version:
//				document.getElementById('output').innerHTML = ajax.responseText;
	
				// XML version:
				var data = ajax.responseXML;
				console.log(data.documentElement.firstChild.nextSibling.firstChild.nodeValue);
				var chapters = data.getElementsByTagName('chapter');
				var str = '';
				for (var i = 0, count = chapters.length; i < count; i++) {
				    // Use chapters[i].id and chapters[i].value
					str += 'Chapter ' + chapters[i].getAttribute('id') + ': ' + chapters[i].firstChild.nodeValue + '<br>'
				}
				document.getElementById('output').innerHTML = str;
				
				// JSON version:
				/*
				var data = JSON.parse(ajax.responseText);
				var str = '';
				str += 'Chapter 1: ' + data[1].title + '<br>'
				str += 'Chapter 2: ' + data[2].title + '<br>'
				document.getElementById('output').innerHTML = str;
				*/
				
		    } else { // Status error!
				document.getElementById('output').innerHTML = ajax.statusText;
		    }
					
		} // End of readyState IF.

	}; // End of onreadystatechange anonymous function.

    // Add an event handler to the button:
    document.getElementById('btn').onclick = function() {

		// Open the request:
	    ajax.open('GET', 'resources/test.xml', true);
	
		// Send the request:
		ajax.send(null);
		
	}; // End of onclick anonymous function.
    
}; // End of onload anonymous function.