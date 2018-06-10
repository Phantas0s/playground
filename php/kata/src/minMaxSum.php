<?php

//https://www.hackerrank.com/challenges/mini-max-sum

const COUNT_NUMBERS = 5;

$handle = fopen("php://stdin", "r");
$totalNumbers = explode(' ', str_replace(PHP_EOL, '', fgets($handle)));

$results = [];

for ($i = 0; $i < COUNT_NUMBERS; $i++) {
    $numbers = $totalNumbers;
    unset($numbers[$i]);

    $results[] = array_sum($numbers);
}

echo min($results) . ' ' . max($results);
