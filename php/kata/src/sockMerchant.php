<?php

//https://www.hackerrank.com/challenges/sock-merchant

$handle = fopen ("php://stdin","r");
fscanf($handle,"%d",$countTotalSocks);

$totalSocks = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

$numberSocksByColor = array_count_values($totalSocks);
$countSockColors = count($numberSocksByColor);

$sockPairsByColor = 0;

foreach ($numberSocksByColor as $numberSocks) {
    if ($numberSocks >= 2) {
        $sockPairsByColor += floor($numberSocks / 2);
    }
}

echo $sockPairsByColor;
