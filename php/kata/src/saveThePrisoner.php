<?php

//https://www.hackerrank.com/challenges/save-the-prisoner

$fp = fopen("php://stdin", "r");
fscanf($fp, "%d", $numberCase);

$answers = [];
for ($i=0; $i < $numberCase; $i++) {
    fscanf($fp, "%d %d %d", $countPrisoners, $countSweets, $startPrisoner);

    $answers[] = (($countSweets - 1 + $startPrisoner - 1) % $countPrisoners) + 1;
}

echo implode(PHP_EOL, $answers);
