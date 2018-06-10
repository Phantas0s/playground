<?php

//https://www.hackerrank.com/challenges/repeated-string

$handle = fopen("php://stdin", "r");
fscanf($handle, "%s", $word);
fscanf($handle, "%ld", $totalLetters);

$wordLetterA = count_chars($word)[97];
$wordLetters = str_split($word);

$numberWordPossible = floor($totalLetters / strlen($word));

$restLetter = ($totalLetters % strlen($word));
$restLetterA = 0;

for ($i = 0; $i < $restLetter; $i++) {
    $restLetterA += count_chars($wordLetters[$i])[97];
}

echo $numberWordPossible * $wordLetterA + $restLetterA;
