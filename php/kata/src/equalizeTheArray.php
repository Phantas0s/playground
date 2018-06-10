<?php

//https://www.hackerrank.com/challenges/equality-in-a-array

$handle = fopen("php://stdin", "r");

fscanf($handle, "%d", $countElements);
$elements = explode(" ", str_replace(PHP_EOL, '', fgets($handle)));

$countSameElements = array_count_values($elements);
arsort($countSameElements);

$firstElement = key($countSameElements);

$elementsToDelete = 0;

foreach ($countSameElements as $element => $countElement) {
    if ($firstElement == $element) {
        continue;
    }

    $elementsToDelete += $countElement;
}

echo $elementsToDelete;
