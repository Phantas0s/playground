// Script 9.11 - cookies.js
// This script defines an object that has some cookie functions.

// Create one global object:
var COOKIE = {
    
    // Function for setting a cookie:
    setCookie: function(name, value, expire) {
        'use strict';

        // Add validation!

        // Begin creating the value string:
        var str =  encodeURIComponent(name) + '=' + encodeURIComponent(value);
    
        // Add the expiration:
        str += ';expires=' + expire.toGMTString(); 
    
        // Create the cookie:
        document.cookie = str;

    }, // End of setCookie() function.
    
    // Function for retrieving a cookie value:
    getCookie: function(name) {
        'use strict';

        // Useful to know how long the cookie name is:
        var len = name.length;
        
        // Split the cookie value:
        var cookies = document.cookie.split(';');

        // Loop through the values:
        for (var i = 0, count = cookies.length; i < count; i++) {

            // Lop off an initial space:
            var value = (cookies[i].slice(0,1) == ' ') ? cookies[i].slice(1) : cookies[i];

			// Decode the value:
			value = decodeURIComponent(value);

            // Check if this iteration matches the name:
            if (value.slice(0,len) == name) {

                // Return the part after the equals sign:
                return value.split('=')[1];

            } // End of IF.
            
        } // End of FOR loop.
            
        // Return false if nothing's been returned yet:
        return false;

    }, // End of getCookie() function.
    
    // Function for deleting cookies:
    deleteCookie: function(name) {
        'use strict';
        document.cookie = encodeURIComponent(name) + '=;expires=Thu, 01-Jan-1970 00:00:01 GMT';
    } // End of deleteCookie() function.

}; // End of COOKIE declaration.