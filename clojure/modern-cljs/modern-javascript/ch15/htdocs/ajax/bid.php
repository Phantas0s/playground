<?php # view.php
// This page handles the bid form via Ajax!
// Returns JSON.

// Always need the configuration file:
require('../includes/config.inc.php');

// Script returns JSON:
header('Content-Type: application/json');

// Default response:
$data = array('status' => 'error', 'message' => 'An invalid bid was submitted.');

// Validate the itemId, the bid, and the user ID:
if (isset($_GET['itemId']) && filter_var($_GET['itemId'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	$itemId = $_GET['itemId'];
}
if (isset($_GET['bid']) && filter_var($_GET['bid'], FILTER_VALIDATE_FLOAT) && ($_GET['bid'] > $_GET['currentPrice']) ) {
	$bid = $_GET['bid'];
} 
// Need the session:
session_start();
if (isset($_SESSION['userId']) && filter_var($_SESSION['userId'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	$userId = $_SESSION['userId'];
}

if (isset($itemId, $bid, $userId)) { // Okay to enter bid:
		
	// Need the database connection:
	require (MYSQL);
		
	// Query the database:
	$q = "INSERT INTO bids (itemId, userId, bid, dateSubmitted) VALUES ($itemId, $userId, $bid, UTC_TIMESTAMP())";
	$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));

	if (@mysqli_affected_rows($dbc) == 1) { // Bid was accepted.
		$data = array('status' => 'accepted', 'message' =>  'Your bid of $' . number_format($bid, 2) . ' has been accepted.');
	} else { // No match.
		$data = array('status' => 'error', 'message' => 'Your bid could not be accepted due to a system error. We apologize for the convenience.');
	}

	mysqli_close($dbc);
	
}// End of validation IF-ELSE.

// Print the JSON data:
echo json_encode($data);