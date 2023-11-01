<?php
function sumOfEvenNumbers($start, $end) {
    $sum = 0;
    for ($i = $start; $i <= $end; $i++) {
        if ($i % 2 == 0) {
            $sum += $i;
        }
    }
    return $sum;
}

$start = 1;
$end = 10;

$evenSum = sumOfEvenNumbers($start, $end);

echo "Finding the sum of even numbers from $start to $end:<br>";
echo "The sum of even numbers in the range is: $evenSum";
?>
