<?php

//https://www.hackerrank.com/challenges/kangaroo

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d %d %d %d", $position1, $speed1, $position2, $speed2);

$answer = 'NO';

if (($speed1 != $speed2) && (($position2 - $position1) % ($speed1 - $speed2)) ===  0) {
    $answer = 'YES';
}

if (($position1 < $position2) && ($speed1 < $speed2)) {
    $answer =  'NO';
}

echo $answer;
