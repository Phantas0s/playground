<?php # index.php
// This is the main page for the site.
// This page lists the open auctions.

// Always need the configuration file first:
require('includes/config.inc.php');

// Set the page title and include the HTML header:
$page_title = 'Current Auctions';
include ('includes/header.html');

// For logging out:
//$_SESSION = array();

// Show the current auctions:
echo '<h1>Current Open Auctions</h1>
	<p>Auctions are listed from those closing soonest to those closing last. ';
	
if (isset($_SESSION['timezone'])) {
	echo 'All times are reflected using your chosen timezone. ';
} else {
	echo 'All times are Universal Coordinated Time. Please <a href="login.php">log in</a> to have times shown in your chosen timezone. ';
}

// Start the table:
echo '</p><table>
	<caption>Click on an item to view that auction.</caption>
		<thead><tr><th>Item</th><th>Current</th><th>Closes</th></tr></thead>
		<tbody>
';

// Need the database connection:
require(MYSQL);

// If the user is logged in and has chosen a time zone,
// use that to convert the dates and times:
if (isset($_SESSION['timezone'])) {
	$tz = "CONVERT_TZ(dateClosed, 'UTC', '{$_SESSION['timezone']}')";
} else {
	$tz = 'dateClosed';
}

// Make the query:
$q = "SELECT items.itemId, item, COALESCE(MAX(bid), openingPrice), IF($tz < DATE_ADD(UTC_TIMESTAMP(), INTERVAL 24 HOUR), DATE_FORMAT($tz,'%l:%i %p'), DATE_FORMAT($tz,'%M %D @ %l:%i %p')) FROM items LEFT JOIN bids USING (itemId) WHERE dateClosed > UTC_TIMESTAMP() GROUP BY items.itemId ORDER BY dateClosed ASC";
$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));
// List each item:
while (list($itemId, $item, $price, $dateClosed) = mysqli_fetch_array($r, MYSQLI_NUM)) {
	echo "<tr><td><a href=\"view.php?itemId=$itemId\">$item</a></td><td>\$$price</td><td>$dateClosed</td></tr>\n";
}

// Clean up:
mysqli_free_result($r);
mysqli_close($dbc);

// Complete the table:
echo '</tbody></table>';

// Include the footer:
include ('includes/footer.html'); 
?>