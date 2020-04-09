// view.js
// This script uses Ajax to dynamically handle the bid form submission.
// Ajax is also used to retrieve the newest bids.

// Wrap it all in an immediately-invoked function:
(function() {
    'use strict';
    
    // Want closure variables that are reusable:
    var bidAjax = null;
    var getBidsAjax = U.getXMLHttpRequestObject();
    var messageDiv = null;
    
    // Function used to show messages:
	function showMessage(message, messageClass) {
    
	    // Get a reference to the DIV:
	    if (!messageDiv) {
	        messageDiv = U.$('messageDiv');
	    }
        
		// If the DIV doesn't exist, create it:
		if (!messageDiv) {
		    messageDiv = document.createElement('div');
		    messageDiv.id = 'messageDiv';
		    var itemHeading = U.$('itemHeading');
		    itemHeading.parentNode.insertBefore(messageDiv, itemHeading);
		} // End of messageDiv IF-ELSE
        
        // Update the DIV:
	    messageDiv.className = messageClass;
	    messageDiv.innerHTML = message;

	} // End of showMessage() function.

    // Function called when the bidAjax call is made:
	function handleBidAjaxResponse() {

	    // Check the readyState:
	    if (bidAjax.readyState == 4) {

	        // Check the status code:
	        if ( (bidAjax.status >= 200 && bidAjax.status < 300) 
	        || (bidAjax.status == 304) ) {
                
                // Parse the response:
				var bidResponse = JSON.parse(bidAjax.responseText);

				// Check the response:
				if (bidResponse.status == 'accepted') {
    
				    // Show the message:
				    showMessage(bidResponse.message, 'good');

				    // Get the bids:
				    getBids();
    
				} else { // Error!
				    // Show the message:
				    showMessage(bidResponse.message, 'error');
				}
                
	        } else { // Bad status, formally submit the form:
	            U.$('bidForm').submit();
	        }

	    } // End of readyState IF.
    
	} // End of handleBidAjaxResponse() function.

    // Function called when the bid form is submitted.
    // Function validates the form data and makes an Ajax request.
	function submitBid(e) {

	    // Get the event object:
	    if (typeof e == 'undefined') e = window.event;

	    // Prevent the form's submission:
	    if (e.preventDefault) {
	        e.preventDefault();
	    } else {
	        e.returnValue = false;
	    }

        // Get reference to the form element:
		var bid = U.$('bid').value;

		// Make sure the bid is higher than the currentPrice:
		if (bid > currentPrice) {
            
            // Create the AJax object, if that hasn't yet been done:
			if (!bidAjax) {
			    bidAjax = U.getXMLHttpRequestObject();
			    bidAjax.onreadystatechange = handleBidAjaxResponse;
			}       

            // Perform an Ajax request:
			bidAjax.open('GET', 'ajax/bid.php?bid=' + bid + '&itemId=' + itemId + '&currentPrice=' + currentPrice, true);
			bidAjax.send(null); 
    
	    } else {
	        showMessage('Your bid must be greater than $' + currentPrice.toFixed(2) + '.', 'error');
	    }

	    return false;

	} // End of submitBid() function.

    // Function called when the getBidsAjax call is made:
	function handleGetBidsAjaxResponse() {
    
	    // Check the readyState:
	    if (getBidsAjax.readyState == 4) {

	        // Check the status code:
	        if ( (getBidsAjax.status >= 200 && getBidsAjax.status < 300) 
	        || (getBidsAjax.status == 304) ) {

                // Parse the response:
				var bids = JSON.parse(getBidsAjax.responseText);

				// If data was returned, update the table:
				if (bids.length > 0) {
                    
                    // Update the current price to the first value:
					currentPrice = parseFloat(bids[bids.length-1].bid).toFixed(2);

					// Update the currentSpan and hidden form input:
					U.setText('currentSpan', currentPrice.toString());
					U.setText('currentHidden', currentPrice.toString());
                    
                    // Need a reference to the table body:
					var tb = U.$('tableBody');

					// Loop through the data:
					for (var i = 0, count = bids.length; i < count; i++) {
    
					    // Create a new table row with two cells:
					    var tr = document.createElement('tr');
					    var td1 = document.createElement('td');
					    var td2 = document.createElement('td');
    
					    // Add the text:
					    td1.appendChild(document.createTextNode('$' + bids[i].bid));
					    td2.appendChild(document.createTextNode(bids[i].dateSubmitted));
    
					    // Add the cells to the row:
					    tr.appendChild(td1);
					    tr.appendChild(td2);
    
					    // Add the row as the second row in the table:
					    var trs = document.getElementsByTagName('tr');
					    tb.insertBefore(tr, trs[1]);
    
					} // End of FOR loop.
               
	            } // End of bids.length IF.

	        } // End of status IF.

	    } // End of readyState IF.
   
	} // End of handleGetBidsAjaxResponse() function.
    
    // Function that gets the updated bids:
	function getBids() {
	    getBidsAjax.open('GET', 'ajax/getBids.php?currentPrice=' + currentPrice + '&itemId=' + itemId, true);
	    getBidsAjax.send(null); 
	}

    // Function called when the window has been loaded.
    // Function needs to add an event listener to the form.
    // Function also needs to prepare the getBidsAjax object.
	function init() {
    
	    // Hide the refresh message, as that's being done by JavaScript:
	    U.$('refreshMessage').style.display = 'none';

	    // Handle form submissions:
	    U.addEvent(U.$('bidForm'), 'submit', submitBid);
    
	    // Setup the bidding Ajax object:
	    getBidsAjax.onreadystatechange = handleGetBidsAjaxResponse;
    
        // Create a timer to fetch new bids every ten seconds:
		var getBidsTimer = setInterval(getBids, 10000);
        
        // If the auction closes within an hour, show the time left:
		if (minutesRemaining < 60) { // Show the timer.

		    // Get the span:
		    var span = U.$('minutesRemainingSpan');

		    // Create the timer:
		    var closingTimer = setInterval(function() {
                
                // One minute less remaining:
				minutesRemaining--;

				if (minutesRemaining > 0) {

				    // Update the span:
				    U.setText('minutesRemainingSpan', minutesRemaining + ' minute(s) left');

				} else { // Auction is over!

				    // Stop both timers:
				    clearInterval(closingTimer);
				    clearInterval(getBidsTimer);
    
				    // Clear the Ajax objects:
				    bidAjax = null;
				    getBidsAjax = null;
    
				    // Remove the event handler:
				    U.removeEvent(U.$('bidForm'), 'submit', submitBid);

				    // Remove the bid form:
				    var bidForm = U.$('bidForm');
				    bidForm.parentNode.removeChild(bidForm);
    
				    // Remove the span:
				    span.parentNode.removeChild(span);

				    // Indicate a message:
				    showMessage('The auction is now closed.', 'error');

				}               
                
	        }, 60000);
    
	    } // End of minutesRemaining IF.
    
	} // End of init() function.    

    // Assign an event listener to the window's load event:
    U.addEvent(window, 'load', init);
    
})(); // End of immediately-invoked function.