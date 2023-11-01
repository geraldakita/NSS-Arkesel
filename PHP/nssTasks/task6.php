<?php

// connect to the database
$conn = mysqli_connect('localhost', 'root', '', 'userTable');

// check connection
if (!$conn) {
    echo 'Connection error: ' . mysqli_connect_error();
}

if (isset($_POST['submit'])) {
    $first_name = mysqli_escape_string($conn, $_POST["first_name"]);
    $last_name = mysqli_escape_string($conn, $_POST["last_name"]);
    $email = mysqli_escape_string($conn, $_POST["email"]);
    $phone = mysqli_escape_string($conn, $_POST["phone"]);



    // create sql
    $sql = "INSERT INTO users(first_name, last_name, email, phone) VALUES('$first_name','$last_name','$email', '$phone')";

    // save to db and check
    if (mysqli_query($conn, $sql)) {
        // success
        echo "<p>Data successfully inserted into database</p>";

        echo "<p>First Name: $first_name</p>";
        echo "<p>Last Name: $last_name</p>";
        echo "<p>Email: $email</p>";
        echo "<p>Phone Number: $phone</p>";
    } else {
        echo 'query error: ' . mysqli_error($conn);
    }
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

    <form method="POST" action="task6.php">
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