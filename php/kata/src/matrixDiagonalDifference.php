<?php

//https://www.hackerrank.com/challenges/diagonal-difference

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $n);
$a = array();

$firstDiagonal = [];
$lastDiagonal = [];

$countFirstDiagonal = 0;

$countLastDiagonal = $n - 1;

for ($i = 0; $i < $n; $i++) {
    $a = explode(" ", fgets($handle));

    $firstDiagonal[] = $a[$countFirstDiagonal];
    $lastDiagonal[] = $a[$countLastDiagonal];

    $countFirstDiagonal++;
    $countLastDiagonal--;
}

echo (int)abs((array_sum($firstDiagonal) - array_sum($lastDiagonal)));