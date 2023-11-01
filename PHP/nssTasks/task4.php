<?php
if (isset($_POST['submit'])) {
    $first_name = $_POST["first_name"];
    $last_name = $_POST["last_name"];
    $email = $_POST["email"];
    $phone = $_POST["phone"];

    echo "<p>First Name: $first_name</p>";
    echo "<p>Last Name: $last_name</p>";
    echo "<p>Email: $email</p>";
    echo "<p>Phone Number: $phone</p>";
} else {
    echo "<p>Enter Data to be submitted</p>";
}
?>


<!DOCTYPE html>
<html>

<head>
    <title>Form Example</title>
</head>

<body>
    <h1>Form Example</h1>

    <form method="POST" action="task4.php">
        <label for="first_name">First Name:</label>
        <input type="text" name="first_name" required><br>

        <label for="last_name">Last Name:</label>
        <input type="text" name="last_name" required><br>

        <label for="email">Email:</label>
        <input type="email" name="email" required><br>

        <label for="phone">Phone Number:</label>
        <input type="tel" name="phone" required><br>

        <input type="submit" name="submit" value="Submit">
    </form>
</body>

</html>