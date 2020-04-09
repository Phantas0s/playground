// ajax.js # 2
// This script defines a function that creates an XMLHttpRequest object.

// This function returns an XMLHttpRequest object.
function getXMLHttpRequestObject() {
	
    var ajax = null;

	// Most browsers:
	if (window.XMLHttpRequest) {
	    ajax = new XMLHttpRequest();
	} else if (window.ActiveXObject) { // Older IE.
try {
   ajax = new ActiveXObject('MSXML2.XMLHTTP.3.0');
} catch (ex) {
console.log('Could not create the ActiveXObject: ' + error.message + '\n');
}
	}
	
	// Return the object:
    return ajax;

} // End of getXMLHttpRequestObject() function.