<?php

//https://www.hackerrank.com/challenges/ctci-making-anagrams

$handle = fopen("php://stdin", "r");

fscanf($handle, "%s", $firstString);
fscanf($handle, "%s", $secondString);

$splitFirstString = str_split($firstString);
$splitSecondString = str_split($secondString);

$firstStringCountLetters = array_count_values($splitFirstString);
$secondStringCountLetters = array_count_values($splitSecondString);

$numberLetterToDelete = 0;

foreach ($firstStringCountLetters as $letter => $firstStringCountLetter) {
    if (!in_array($letter, array_keys($secondStringCountLetters))) {
        $numberLetterToDelete += $firstStringCountLetter;
        unset($firstStringCountLetters[$letter]);
        continue;
    }

    $letterDifference = abs($firstStringCountLetters[$letter] - $secondStringCountLetters[$letter]);
    $firstStringCountLetters[$letter] = $secondStringCountLetters[$letter] = $letterDifference;
    $numberLetterToDelete += $letterDifference;
}

foreach ($secondStringCountLetters as $letter => $secondStringCountLetter) {
    if (!in_array($letter, array_keys($firstStringCountLetters))) {
        $numberLetterToDelete += $secondStringCountLetter;
    }
}

echo $numberLetterToDelete;
