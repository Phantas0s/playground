<?php

//https://www.hackerrank.com/challenges/chocolate-feast


$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $countTrip);

$data = [];

for ($i = 0; $i < $countTrip; $i++) {
    fscanf($handle, "%d %d %d", $data[$i]['totalDollars'], $data[$i]['itemCostDollars'], $data[$i]['itemCostWrapper']);
}

$countTrip = count($data);

for ($i = 0; $i < $countTrip; $i++) {
    $wrappers = 0;
    $chocolateBought = 0;

    $chocolateBought = (
        $data[$i]['totalDollars'] - $data[$i]['totalDollars'] % $data[$i]['itemCostDollars']
        ) / $data[$i]['itemCostDollars'];

    $wrappers += $chocolateBought;

    while ($wrappers >= $data[$i]['itemCostWrapper']) {
        $chocolateBoughtWrapper = (
            $wrappers - $wrappers % $data[$i]['itemCostWrapper']
            ) / $data[$i]['itemCostWrapper'];

        $chocolateBought += $chocolateBoughtWrapper;
        $wrappers -= $data[$i]['itemCostWrapper'] * $chocolateBoughtWrapper;
        $wrappers += $chocolateBoughtWrapper;
    }

    echo $chocolateBought . PHP_EOL;
}
