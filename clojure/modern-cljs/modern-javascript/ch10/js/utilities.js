// Script 8.1 - utilities.js
// This script defines an object that has some utilitarian functions.

var U = {

    // For getting the document element by ID:
    $: function(id) {
        'use strict';
        if (typeof id == 'string') {
            return document.getElementById(id);
        }
    }, // End of $() function.

    // Function for setting the text of an element:
    setText: function(id, message) {
        'use strict';
        if ( (typeof id == 'string')
        && (typeof message == 'string') ) {
    
            // Get a reference to the element:
            var output = this.$(id);
            if (!output) return false;
        
            // Set the text
            if (output.textContent !== undefined) {
                output.textContent = message;
            } else {
                output.innerText = message;
            }
            return true;
        } // End of main IF.
    }, // End of setText() function.
    
    // Function for creating event listeners:
    addEvent: function(obj, type, fn) {
        'use strict';
        if (obj && obj.addEventListener) { // W3C
            obj.addEventListener(type, fn, false);
        } else if (obj && obj.attachEvent) { // Older IE
            obj.attachEvent('on' + type, fn);
        }
    }, // End of addEvent() function.
    
    // Function for removing event listeners:
    removeEvent: function(obj, type, fn) {
        'use strict';
        if (obj && obj.removeEventListener) { // W3C
            obj.removeEventListener(type, fn, false);
        } else if (obj && obj.detachEvent) { // Older IE
            obj.detachEvent('on' + type, fn);
        }
    }, // End of removeEvent() function.

	enableTooltips: function(id) {
	    'use strict';
	
		// Get a reference to the element:
		var elem = this.$(id);

		// Add four event handlers to the element:
		this.addEvent(elem, 'focus', this.showTooltip);
	    this.addEvent(elem, 'mouseover', this.showTooltip);
	    this.addEvent(elem, 'blur', this.hideTooltip);
	    this.addEvent(elem, 'mouseout', this.hideTooltip);
	
	}, // End of enableTooltips() function.

	showTooltip: function(e) {
	    'use strict';
	
		// Get the event object:
		if (typeof e == 'undefined') var e = window.event;

		// Get the event target:
		var target = e.target || e.srcElement;
		target.previousSibling.lastChild.style.visibility = 'visible';

	}, // End of showTooltip() function.

	hideTooltip: function(e) {
	    'use strict';
	
		// Get the event object:
		if (typeof e == 'undefined') var e = window.event;

		// Get the event target:
		var target = e.target || e.srcElement;
		target.previousSibling.lastChild.style.visibility = 'hidden';

	} // End of hideTooltip() function.

}; // End of U declaration.