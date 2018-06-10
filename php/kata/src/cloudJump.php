<?php

//https://www.hackerrank.com/challenges/jumping-on-the-clouds

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $countClounds);
$clouds = explode(" ", fgets($handle));

$position = 0;
$goalPosition = $countClounds - 1;
$countMove = 0;

while ($position != $goalPosition) {
    if (isset($clouds[$position + 2]) && $clouds[$position + 2] == 0) {
        $position += 2;
        $countMove++;
        continue;
    }

    if ($clouds[$position + 1] == 0) {
        $position += 1;
        $countMove++;
        continue;
    }

    throw new Exception('Impossible to finish the game!!!');
}

echo $countMove;
