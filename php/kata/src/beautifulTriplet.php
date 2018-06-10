<?php

//https://www.hackerrank.com/challenges/beautiful-triplets

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d", $countNumbers, $beautifulDifference);

$tripletSequence = explode(' ', fgets($handle));

$indexTripletSequence = $countNumbers - 1;
$tripletCount = 0;
$triplets = [];

for ($i = $indexTripletSequence; $i >= 0; $i--) {
    $count = 0;

    for ($j = $i - 1; $j >= 0; $j--) {
        if ($tripletSequence[$i] - $tripletSequence[$j] == $beautifulDifference) {
            $count++;

            if (isset($triplets[$tripletSequence[$i]])) {
                $tripletCount++;
            }

            $triplets[$tripletSequence[$j]] = $tripletSequence[$i];
        }
    }
}

echo $tripletCount;
