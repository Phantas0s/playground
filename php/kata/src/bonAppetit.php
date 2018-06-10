<?php

//https://www.hackerrank.com/challenges/bon-appetit

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d", $itemNumber, $rejectedItem);
$itemPrices = explode(" ", fgets($handle));
fscanf($handle, "%d", $annaTotalPaid);

$totalPaid = array_sum($itemPrices);

$annaNotPay = $itemPrices[$rejectedItem] / 2;
$annaRealShare = ($totalPaid / 2) - $annaNotPay;

echo $annaRealShare != $annaTotalPaid ? $annaNotPay : 'Bon Appetit';
