<?php

//https://www.hackerrank.com/challenges/apple-and-orange

$handle = fopen("php://stdin", "r");

fscanf($handle, "%d %d", $leftWallHouse, $rightWallHouse);
fscanf($handle, "%d %d", $leftAppleTree, $rightOrangeTree);
fscanf($handle, "%d %d", $apples, $oranges);

$appleDistancesFromTree = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));
$orangeDistancesFromTree = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

$applesOnTheHouse = 0;
$orangesOnTheHouse = 0;

for ($i = 0; $i < $apples; $i++) {
    if ($appleDistancesFromTree[$i] <= 0) {
        continue;
    }

    $applePosition = $leftAppleTree + $appleDistancesFromTree[$i];

    if ($applePosition >= $leftWallHouse && $applePosition <= $rightWallHouse) {
        $applesOnTheHouse++;
    }
}

for ($j = 0; $j < $oranges; $j++) {
    if ($orangeDistancesFromTree[$j] >= 0) {
        continue;
    }

    $orangePosition = $rightOrangeTree + $orangeDistancesFromTree[$j];

    if ($orangePosition >= $leftWallHouse && $orangePosition <= $rightWallHouse) {
        $orangesOnTheHouse++;
    }
}

echo $applesOnTheHouse . PHP_EOL;
echo $orangesOnTheHouse . PHP_EOL;
