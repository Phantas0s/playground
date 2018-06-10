<?php

//https://www.hackerrank.com/challenges/string-construction

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $countInputString);

$inputStrings = [];

for ($i = 0; $i < $countInputString; $i++) {
    fscanf($handle, "%s", $inputStrings[]);
}

for ($i = 0; $i < $countInputString; $i++) {
    $copiedString=[];
    $cost = 0;

    $inputString = str_split($inputStrings[$i]);
    $countInputStringLetters = count($inputString);

    for ($j = 0; $j < $countInputStringLetters; $j++) {
        if (!in_array($inputString[$j], $copiedString)) {
            $cost++;
        }

        $copiedString[] = $inputString[$j];
    }

    echo $cost . PHP_EOL;
}

