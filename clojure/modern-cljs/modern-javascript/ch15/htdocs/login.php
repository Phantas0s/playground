<?php # login.php
// This page both displays and handles the login form.

// Always need the configuration file:
require('includes/config.inc.php');

// Set the page title and include the HTML header:
$page_title = 'Login';
include ('includes/header.html');

// Include the heading here:
echo '<h1>Login</h1><p id="message">Registered users must log in to submit bids.</p>
';

// Check for a form submission:
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	
	// Need the database:
	require (MYSQL);
	
	// Array for storing errors:
	$errors = array();
	
	// Validate the username:
	if (isset($_POST['username']) && !empty($_POST['username'])) {
		$u = mysqli_real_escape_string ($dbc, $_POST['username']);
	} else {
		$errors[] = 'You forgot to enter your username!';
	}
	
	// Validate the password:
	if (isset($_POST['userpass']) && !empty($_POST['userpass'])) {
		$p = mysqli_real_escape_string ($dbc, $_POST['userpass']);
	} else {
		$errors[] = 'You forgot to enter your password!';
	}
	
	if (empty($errors)) { // No errors!
		
		// Query the database:
		$q = "SELECT userId, username, timezone FROM users WHERE (username='$u' AND userpass=SHA1('$p'))";
		$r = mysqli_query ($dbc, $q) or trigger_error("Query: $q\n<br />MySQL Error: " . mysqli_error($dbc));
		
		if (@mysqli_num_rows($r) == 1) { // A match was made.
			
			// Store the data in the session:
			$_SESSION = mysqli_fetch_array ($r, MYSQLI_ASSOC); 
			
			// Clean up:
			mysqli_free_result($r);
			mysqli_close($dbc);
			
			// Display the status:
			echo '<p class="good">You are now logged in.</p>';
			
			// Include the footer:
			include ('includes/footer.html');
			
			// Quit the script:
			exit(); 
			
		} else { // No match.
			$errors[] = 'The values provided do not match those on file.';
		}

	} // End of $errors IF.

	// Close the database connection:
	mysqli_close($dbc);
	
} // End of form submission check.

// Display any errors:
if (isset($errors) && is_array($errors)) {
	echo '<h2>Error!</h2><p>The following error(s) occurred:<ul>';
	foreach ($errors as $error) {
		echo "<li class=\"error\">$error</li>";
	}
	echo '</ul></p>';
	
}

// Show the form:
?>
<form action="login.php" method="post" id="loginForm">
	<label>Username</label>
	<input name="username" id="username" type="text">
	<label>Password</label>
	<input name="userpass" id="userpass" type="password">
	<br>
	<input class="button" type="submit" value="Login">
</form>

<script src="js/login.js"></script>

<?php include ('includes/footer.html'); ?>