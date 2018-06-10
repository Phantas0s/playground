<?php

//https://www.hackerrank.com/contests/master/challenges/minimum-distances

const NO_DUPLICATE_VALUE_RESULT = '-1';

$handle = fopen("php://stdin", "r");
fscanf($handle, "%s", $n);
$baseData = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

$unique = array_unique($baseData, SORT_NUMERIC);
$duplicateValues = array_diff_assoc($baseData, $unique);

$duplicates = [];
$distances = [];

foreach ($baseData as $baseKey => $baseValue) {
    if (in_array($baseValue, $duplicateValues)) {
        $duplicates[$baseValue][] = $baseKey;
    }
}

if (empty($duplicates)) {
    echo  NO_DUPLICATE_VALUE_RESULT;
    exit;
}

$distances = [];

foreach ($duplicates as $duplicateValue => $duplicateKeys) {
    $distances[$duplicateValue] = false;

    foreach ($duplicateKeys as $duplicateKey) {
        $distances[$duplicateValue] = $distances[$duplicateValue] === false ?
            $duplicateKey : abs($distances[$duplicateValue] -= $duplicateKey);
    }
}

echo min($distances);