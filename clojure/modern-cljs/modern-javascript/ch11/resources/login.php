<?php # Script 13.3 - login.php

if ( isset($_POST['email'], $_POST['password']) 
    && ($_POST['email'] == 'test@example.com') 
    && ($_POST['password'] == 'securepass') ) {
		echo 'VALID';
} else {
	echo 'INVALID';
}
?>