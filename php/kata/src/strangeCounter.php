<?php

//https://www.hackerrank.com/challenges/strange-code

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $time);

$referenceTime = 1;
$referenceValue = 3;

while ($time > $referenceTime) {
    $referenceTime = $referenceTime + $referenceValue;
    $referenceValue = $referenceValue * 2;
}

if ($time < $referenceTime) {
    $referenceTime = $referenceTime - $referenceValue / 2;
    $referenceValue = $referenceValue / 2;
}

$referenceValue = $referenceValue - ($time-$referenceTime);

echo $referenceValue;
