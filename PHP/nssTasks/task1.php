<?php
$monthlyGrossSalary = 6000; 
$monthlyNetSalary = 5000;
$monthlyHouseholdExpenditure = 2000; 


$annualGrossSalary = $monthlyGrossSalary * 12;
$annualNetSalary = $monthlyNetSalary * 12;
$annualHouseholdExpenditure = $monthlyHouseholdExpenditure * 12;

$yearlyProfit = $annualNetSalary - $annualHouseholdExpenditure;

// Output
echo "Task 1" . '<br/>';
echo "Annual Gross Salary: $" . $annualGrossSalary . '<br/>';
echo "Annual Net Salary: $" . $annualNetSalary . '<br/>';
echo "Annual Household Expenditure: $" . $annualHouseholdExpenditure . '<br/>';
echo "Yearly Profit: $" . $yearlyProfit . '<br/>';
?>
