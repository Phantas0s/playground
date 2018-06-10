<?php

//https://www.hackerrank.com/challenges/ctci-array-left-rotation

$rotations = 0;

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d", $baseDataCount, $rotations);
$baseArray = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

for ($i = 0; $i < $rotations; $i++) {
    $baseArray[] =$baseArray[$i];
    unset($baseArray[$i]);
}

echo implode(' ', $baseArray);
