<?php # getBids.php
// This page returns the bids for an item over a certain amount.

// Always need the configuration file:
require('../includes/config.inc.php');

// Script returns JSON:
header('Content-Type: application/json');

// For storing results:
$data = array();

// Need the itemId and current price:
if (isset($_GET['itemId']) && filter_var($_GET['itemId'], FILTER_VALIDATE_INT, array('min_range' => 1)) && isset($_GET['currentPrice']) && filter_var($_GET['currentPrice'], FILTER_VALIDATE_FLOAT)) {
	
	// Need the database connection:
	require (MYSQL);
	
	// Need the session:
	session_start();

	// If the user is logged in and has chosen a time zone,
	// use that to convert the dates and times:
	if (isset($_SESSION['timezone'])) {
		$tz = "CONVERT_TZ(dateSubmitted, 'UTC', '{$_SESSION['timezone']}')";
	} else {
		$tz = 'dateSubmitted';
	}
	
	// Query the database:
	$q = "SELECT bid, IF($tz > DATE_SUB(UTC_TIMESTAMP(), INTERVAL 24 HOUR), DATE_FORMAT($tz,'%l:%i %p'), DATE_FORMAT($tz,'%M %D @ %l:%i %p')) AS dateSubmitted FROM bids WHERE itemId={$_GET['itemId']} AND bid>{$_GET['currentPrice']} ORDER BY dateSubmitted ASC";
	$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));
	
	// If there were results, fetch them:
	if (@mysqli_num_rows($r) > 0) {
		while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
			$data[] = $row;
		}
	}
	
	// Perform clean up:
	mysqli_free_result($r);
	mysqli_close($dbc);
	
} // End of validation.

// Print the JSON data:
echo json_encode($data);