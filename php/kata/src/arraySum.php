<?php

//https://www.hackerrank.com/challenges/simple-array-sum/submissions

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $n);
$array = explode(' ', fgets($handle));
echo array_sum($array);
