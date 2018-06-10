<?php

//https://www.hackerrank.com/challenges/camelcase

$handle = fopen("php://stdin", "r");
$strArray = str_split(fgets($handle));

$countWords = 1;

foreach ($strArray as $char) {
    if (strtolower($char) != $char) {
        $countWords++;
    }
}

echo $countWords;
