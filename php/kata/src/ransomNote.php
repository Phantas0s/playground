<?php

//https://www.hackerrank.com/challenges/ctci-ransom-note

const ENOUGH_WORDS_MAGAZINE = 'Yes';
const NOT_ENOUGH_WORDS_MAGAZINE = 'No';

$handle = fopen("php://stdin", "r");

fscanf($handle, "%d %d", $magazineWordsNumber, $ransomWordsNumber);

$magazineWords = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));
$ransomWords = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

$numberWordsInMagazine = 0;
for ($i = 0; $i <  $ransomWordsNumber; $i++) {
    $wordIntersect = array_search($ransomWords[$i], $magazineWords);
    if ($wordIntersect !== false) {
        unset($magazineWords[$wordIntersect]);
        $numberWordsInMagazine++;
    }
}

if ($numberWordsInMagazine == count($ransomWords)) {
    echo ENOUGH_WORDS_MAGAZINE;
} else {
    echo NOT_ENOUGH_WORDS_MAGAZINE;
}