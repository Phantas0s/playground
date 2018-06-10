<?php

//https://www.hackerrank.com/challenges/staircase

$handle = fopen ("php://stdin","r");
fscanf($handle,"%d",$numberStep);

for ($i = 1; $i <= $numberStep ; $i++){
    $staircaseLine = '';
    $numberSpaces = $numberStep - $i;
    $numberSharp = $i;

    for ($j = 0; $j < $numberSpaces; $j++) {
        $staircaseLine .= ' ';
    }

    for ($j = 0; $j < $numberSharp; $j++) {
        $staircaseLine .= '#';
    }

    echo $staircaseLine.PHP_EOL;
}