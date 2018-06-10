<?php

//https://www.hackerrank.com/challenges/the-time-in-words

$handle = fopen("php://stdin", "r");
fscanf($handle, "%d", $hour);
fscanf($handle, "%d", $minute);

$answer = '';

$dictionary = [
    0 => 'zero',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty'
];

if ($minute > 30) {
    $hour += 1;
}

$hour = $dictionary[$hour];

if (!$minute) {
    $answer = $hour . ' o\' clock';
    echo $answer;
    exit;
}

$linkWord = $minute == 30 || $minute < 30 ? 'past' : 'to';

if ($minute % 15 === 0) {
    $minute = $minute == 30 ? 'half' : 'quarter';

    $answer = $minute . ' ' . $linkWord . ' ' . $hour;

    echo $answer;
    exit;
}

if ($minute == 1) {
    $minuteWord = 'minute';
} else {
    $minuteWord = 'minutes';
}

if ($minute > 30) {
    $minute = 60 - $minute;
}

if ($minute <= 10 || $minute % 10 === 0) {
    $answer = $dictionary[$minute] . ' ' . $minuteWord . ' ' . $linkWord . ' ' . $hour;

    echo $answer;
    exit;
}

if ($minute > 20) {
    $minutes = str_split($minute);
    $minuteTens = $dictionary[reset($minutes) * 10];
    $minuteOnes = $dictionary[end($minutes)];
    $minute = $minuteTens . ' ' . $minuteOnes;
} else {
    $minute = $dictionary[$minute];
}


$answer = $minute . ' ' . $minuteWord . ' ' . $linkWord . ' ' . $hour;
echo $answer;

?>
