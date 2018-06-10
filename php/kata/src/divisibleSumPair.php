<?php

//https://www.hackerrank.com/challenges/divisible-sum-pairs

$numberOfInput = null;
$divisibleNumber = null;

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d", $numberOfInput, $divisibleNumber);

$numbers = explode(" ", fgets($handle));

$result = 0;

for ($i=0; $i<$numberOfInput; $i++) {
    for ($j=0; $j<$numberOfInput; $j++) {
        if ($i < $j && (($numbers[$i] + $numbers[$j]) % $divisibleNumber) == 0) {
            $result++;
        }
    }
}

echo $result;
