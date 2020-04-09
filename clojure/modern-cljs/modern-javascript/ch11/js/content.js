// content.js

// Establish functionality on window load:
window.onload = function() {
    'use strict';

	// For managing the pages:
	var pages = ['model', 'view', 'controller'];
	var counter = 0;

	// Fetch the next bit of data:
	var ajax = getXMLHttpRequestObject();
	ajax.open('GET', 'resources/content.php?id=' + pages[counter], false);
	ajax.send(null);
	
	// Get the data:
	var title = ajax.responseXML.getElementsByTagName('title')[0].firstChild.nodeValue;
	var content = ajax.responseXML.getElementsByTagName('content')[0].firstChild.nodeValue;
	
	// Click handler:
	var nextLink = document.getElementById('nextLink');
	nextLink.onclick = function() {
	
		// Update the content:
		document.getElementById('title').innerHTML = title;
		document.getElementById('content').innerHTML = content;
		
		// Increment the counter:
counter++;

if (counter == 3) { // All done!
	nextLink.parentNode.removeChild(nextLink);
	ajax = null;
} else { // Get the next bit of content:
	ajax.open('GET', 'resources/content.php?id=' + pages[counter], false);
	ajax.send(null);
	title = ajax.responseXML.getElementsByTagName('title')[0].firstChild.nodeValue;
	content = ajax.responseXML.getElementsByTagName('content')[0].firstChild.nodeValue;
}		
		
		// Return false to not follow the link:
		return false;
			
	}; // End of onclick anonymous function.
		
}; // End of onload anonymous function.