<?php # Script 13.3 - quote.php

// Set the content type:
header('Content-Type: application/json');

// Setup cURL:
$curl = curl_init('http://www.google.com/finance/info?infotype=infoquoteall&q=AAPL');

// Want to assign the results to a variable:
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
$result = curl_exec($curl);

// Close it:
curl_close($curl);

// Cut off the first three characters:
print substr($result,3);
?>