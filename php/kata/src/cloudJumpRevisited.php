<?php

//https://www.hackerrank.com/challenges/jumping-on-the-clouds-revisited

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d", $goalPosition, $jumpDistance);
$clouds = explode(" ", fgets($handle));

$clouds[] = $clouds[0];

$position = 0;
$energy = 100;

while ($position != $goalPosition) {
    $position += $jumpDistance;
    $clouds[$position] == 1 ? $energy-=3 : $energy-=1;
}

echo $energy;
