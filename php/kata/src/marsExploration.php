<?php

//https://www.hackerrank.com/challenges/mars-exploration

$handle = fopen("php://stdin", "r");
fscanf($handle, "%s",  $sos);

$sosArray = str_split($sos);
$countSosArray = count($sosArray);

$countBadLetter = 0;
$numberLetterProcessed = 0;

$sosWord = [];

for ($i=0; $i<$countSosArray; $i++) {
    $numberLetterProcessed++;
    $sosWord[$i] = $sosArray[$i];

    if ($numberLetterProcessed % 3 == 0) {
        reset($sosWord) == 'S' ?:$countBadLetter++;
        next($sosWord) == 'O' ?:$countBadLetter++;
        end($sosWord) == 'S' ?:$countBadLetter++;

        $sosWord=[];
    }
}

echo $countBadLetter;
