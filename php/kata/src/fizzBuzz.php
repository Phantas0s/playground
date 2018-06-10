<?php

//Classic FizzBuzz

$count = 0;

for ($i = 0; $i <= 100; $i++) {
    $result = '';

    if ($i % 3 === 0) {
        $result .= 'Fizz';
    }

    if ($i % 5 === 0) {
        $result .= 'Buzz';
    }

    if (empty($result)) {
        $result = $i;
    }

    echo $result . PHP_EOL;
}