<?php # view.php
// This page views the details of a particular auction item and allows the user to bid on the item.

// Always need the configuration file first:
require('includes/config.inc.php');

// Set the page title and include the HTML header:
$page_title = 'View Item';
include ('includes/header.html');

// Validate the itemId:
$itemId = false;
if (isset($_GET['itemId']) && filter_var($_GET['itemId'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	$itemId = $_GET['itemId'];
} elseif (isset($_POST['itemId']) && filter_var($_POST['itemId'], FILTER_VALIDATE_INT, array('min_range' => 1))) { // For form submissions.
	$itemId = $_POST['itemId'];
}

// If an invalid itemId, show and error and terminate the script:
if (!$itemId) {
	echo '<h2>Error!</h2><p class="error">This page has been accessed in error!</p>';
	include ('includes/footer.html');
	exit();
}

// Need the database connection:
require(MYSQL);

// Check for a form submission:
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	
	// Validate the user Id and the bid amount:
	if (isset($_SESSION['userId']) && filter_var($_SESSION['userId'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
		$userId = $_SESSION['userId'];
	}
	if (isset($_POST['bid']) && filter_var($_POST['bid'], FILTER_VALIDATE_FLOAT) && ($_POST['bid'] > $_POST['currentHidden'])) {
		$bid = $_POST['bid'];
	} 
	
	// Post the bid:
	if (isset($userId, $bid)) { // Submit the bid:
		$q = "INSERT INTO bids (itemId, userId, bid, dateSubmitted) VALUES ($itemId, $userId, $bid, UTC_TIMESTAMP())";
		$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));
		if (@mysqli_affected_rows($dbc) == 1) {
			echo '<h2>Bid Accepted!</h2><p class="good">Your bid of $' . $bid . ' has been accepted.</p>';
		} else {
			echo '<h2>Error!</h2><p class="error">Your bid could not be accepted due to a system error. We apologize for the convenience.</p>';
		}
	} else { // Show an error:
		echo '<h2>Error!</h2><p class="error">Your bid could not be accepted. Make sure it is greater than the current high price!</p>';
	}

}

// Get all the bids...

// If the user is logged in and has chosen a time zone,
// use that to convert the dates and times:
if (isset($_SESSION['timezone'])) {
	$closeTz = "CONVERT_TZ(dateClosed, 'UTC', '{$_SESSION['timezone']}')";
	$bidTz = "CONVERT_TZ(dateSubmitted, 'UTC', '{$_SESSION['timezone']}')";
} else {
	$closeTz = 'dateClosed';
	$bidTz = 'dateSubmitted';
}

// Make the query:
$q = "SELECT item, description, openingPrice, COALESCE(MAX(bid), openingPrice), DATE_FORMAT($closeTz,'%M %D @ %l:%i %p'), IF(dateClosed < UTC_TIMESTAMP(), 'closed', 'open'), CEILING((UNIX_TIMESTAMP(dateClosed) - UNIX_TIMESTAMP(UTC_TIMESTAMP()))/60) FROM items LEFT JOIN bids USING (itemId) WHERE items.itemId=$itemId GROUP BY bids.itemId";
$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));

// Fetch the row:
list ($item, $description, $openingPrice, $currentPrice, $dateClosed, $status, $minutesRemaining) = mysqli_fetch_array($r, MYSQLI_NUM);
mysqli_free_result($r);

// Print the initial information:
echo "<h1 id=\"itemHeading\">$item</h1>
<p>$description</p>
<h2>Opening Price: \$$openingPrice</h2>
<h2 id=\"closingH2\">Closes</em>: $dateClosed";

// Check if it's closing soon:
if ( ($minutesRemaining < 60) && ($status == 'open')) {
	echo ' <span id="minutesRemainingSpan" class="caution">' . $minutesRemaining . ' minute(s) left</span>';
}

// Complete the details:
echo '</h2>';

// Start the form for bidding:
if ($status == 'open') {
	
	// Show the header:
	echo '<h3>Bid On This Item</h3>
	<p>Enter a price above $<span id="currentSpan">' .  $currentPrice . '</span> to bid on this item.</p>';

	// If the user is logged in, show the form:
	if (isset($_SESSION['userId'])) {
		echo '<form action="view.php" method="post" id="bidForm">
		<label>Bid</label>
		<input name="bid" id="bid" type="text">
		<br>
		<input class="button" type="submit" value="Bid">
		<input type="hidden" name="itemId" id="itemId" value="' . $itemId . '">
		<input type="hidden" name="currentHidden" id="currentHidden" value="' . $currentPrice . '">
	</form>';
	} else { // Not logged in.
		echo '<p class="caution">You must <a href="login.php">log in</a> to place bids.</p>';
	}
	
	// Create the JavaScript:
	echo '<script>
		var itemId = ' . $itemId . ';
		var currentPrice = ' . $currentPrice . ';
		var minutesRemaining  = ' . $minutesRemaining . ';
	</script>
	<script src="js/view.js"></script>';

} else { // Closed!
	echo '<p class="caution">This auction is now closed.</p>
	<h2>Final Price: $' . $currentPrice .'</h2>';
}

// Display the bids:
// Make the query:
$q = "SELECT bid, IF($bidTz > DATE_SUB(UTC_TIMESTAMP(), INTERVAL 24 HOUR), DATE_FORMAT($bidTz,'%l:%i %p'), DATE_FORMAT($bidTz,'%M %D @ %l:%i %p')) FROM bids WHERE itemId=$itemId ORDER BY bids.bid DESC";
$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));

// Print the header:
echo "<h3>Current Bids</h3>
<p id=\"refreshMessage\"><a href=\"view.php?itemId=" . $itemId . "\">Refresh the page to update.</a></p>
<table>
	<caption>All bids for this item, in descending order.</caption>
	<thead><tr><th>Bid</th><th>Date</th></tr></thead>
	<tbody id=\"tableBody\">
";

// Loop through the results:
while (list ($bid, $bidDate) = mysqli_fetch_array($r, MYSQLI_NUM)) {
	
	// Print the row:
	echo "<tr><td>\$$bid</td><td>$bidDate</td></tr>\n";
		
}

// Clean up:
mysqli_free_result($r);
mysqli_close($dbc);

// Complete the table:
echo '</tbody>
</table>';

// Add a note about times:
if (isset($_SESSION['timezone'])) {
	echo '<p>All times are reflected using your chosen timezone.</p>';
} else {
	echo '<p>All times are Universal Coordinated Time. Please <a href="login.php">log in</a> to have times shown in your chosen timezone.</p>';
}

// Include the footer:
include ('includes/footer.html'); 
?>