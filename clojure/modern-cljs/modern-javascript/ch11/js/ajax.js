// Script 11.1 - ajax.js
// This script defines a function that creates an XMLHttpRequest object.

// This function returns an XMLHttpRequest object.
function getXMLHttpRequestObject() {
	
    var ajax = null;

	// Most browsers:
	if (window.XMLHttpRequest) {
	    ajax = new XMLHttpRequest();
	} else if (window.ActiveXObject) { // Older IE.
	    ajax = new ActiveXObject('MSXML2.XMLHTTP.3.0');
	}
	
	// Return the object:
    return ajax;

} // End of getXMLHttpRequestObject() function.