<?php

//https://www.hackerrank.com/challenges/time-conversion

$handle = fopen("php://stdin", "r");
fscanf($handle, "%s", $fullTime);

$timeFormat = substr($fullTime, -2, 2);
$time = substr($fullTime, 0, -2);

$datetime = new DateTime();
$datetime->modify($time . ' ' . strtolower($timeFormat));

echo $datetime->format('H:i:s');
