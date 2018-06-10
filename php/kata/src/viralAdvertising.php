<?php

//https://www.hackerrank.com/challenges/strange-advertising

const NUMBER_PEOPLE_ADVERTISED_FIRST = 5;

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $numberDays);

$peopleAdvertised = 5;
$totalPeopleInterested = 0;

for ($i = 0; $i < $numberDays; $i++) {
    $peopleInterested = floor($peopleAdvertised/2);
    $peopleAdvertised = $peopleInterested * 3;
    $totalPeopleInterested += $peopleInterested;
}

echo $totalPeopleInterested;
