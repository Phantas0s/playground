// Script 9.13 - theme.js

// Function called to establish the theme:
function setTheme(theme) {
    'use strict';

    // For the style sheet:
    var css = null;
    
    // Create the style sheet, if it doesn't exist:
    if (document.getElementById('cssTheme')) {
        css = document.getElementById('cssTheme');
        css.href = 'css/' + theme + '.css';
    } else { // Create it!
        css = document.createElement('link');
        css.rel = 'stylesheet';
        css.href = 'css/' + theme + '.css';
        css.id = 'cssTheme';
        document.head.appendChild(css);
    }
    
} // End of setTheme() function.

// Function called when the link is clicked.
function setThemeCookie(e) {
    'use strict';

    // Get the event object:
    if (typeof e == 'undefined') e = window.event;

    // Prevent the default behavior:
    if (e.preventDefault) {
        e.preventDefault();
    } else {
        e.returnValue = false;
    }

    // Get the event target:
    var target = e.target || e.srcElement;

    // Set the cookie:
    var expire = new Date(); // Today!
    expire.setDate(expire.getDate() + 7); // One week!
    COOKIE.setCookie('theme', target.id, expire);
    
    // Update the theme:
    setTheme(target.id);

    return false; // Prevent the default behavior.
    
} // End of setThemeCookie() function.

// Establish functionality on window load:
window.onload = function() {
    'use strict';

    // Add click event handlers to each theme link:
    document.getElementById('aTheme').onclick = setThemeCookie;
    document.getElementById('bTheme').onclick = setThemeCookie;
    
    // Get the cookie's value:
    var theme = COOKIE.getCookie('theme');

    // If there was a value, set the theme:
    if (theme) {
        setThemeCookie(theme);
    }
    
}; // End of onload anonymous function.