<?php

//https://www.hackerrank.com/challenges/compare-the-triplets

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d %d", $a0, $a1, $a2);
fscanf($handle, "%d %d %d", $b0, $b1, $b2);

$triplet1 = [$a0, $a1, $a2];
$triplet2 = [$b0, $b1, $b2];

$result1 = 0;
$result2 = 0;

foreach ($triplet1 as $key => $score) {
    if ($score > $triplet2[$key]) {
        $result1 += 1;
    }

    if ($score < $triplet2[$key]) {
        $result2 += 1;
    }
}

echo $result1 . ' ' . $result2;
