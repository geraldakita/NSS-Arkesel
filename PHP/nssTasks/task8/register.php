<?php
include('db_connect.php');

$name = $email = $role = $password = $formError = "";
$errors = array('name' => '', 'email' => '', 'role' => '', 'password' => '', 'error' => '');

if (isset($_POST['register'])) {
    // Check name
    if (empty($_POST['name'])) {
        $errors['name'] = 'Name is required';
    } else {
        $name = $_POST['name'];
    }

    // Check email
    if (empty($_POST['email'])) {
        $errors['email'] = 'Email is required';
    } else {
        $email = $_POST['email'];
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = 'Email must be a valid email address';
        }
    }

    // Check role
    if (empty($_POST['role'])) {
        $errors['role'] = 'Role is required';
    } else {
        $role = $_POST['role'];
        // Check if the role is either "admin" or "user"
        if ($role !== "admin" && $role !== "user") {
            $errors['role'] = 'Role must be "admin" or "user"';
        }
    }

    // Check password
    if (empty($_POST['password'])) {
        $errors['password'] = 'Password is required';
    }
    else {
        $password = $_POST['password'];
        if (!preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$/', $password)) {
            $errors['password'] = 'Password must be at least 8 characters long and contain at least one lowercase letter, one uppercase letter, and one special character.';
        }
    }

    // Checking for errors using array filter before registering
    if (array_filter($errors)) {
        // Handle form errors here or display them to the user
    } else {
        // Escape SQL characters
        $name = mysqli_real_escape_string($conn, $_POST['name']);
        $email = mysqli_real_escape_string($conn, $_POST['email']);
        $role = mysqli_real_escape_string($conn, $_POST['role']);
        $password = mysqli_real_escape_string($conn, $_POST['password']);

        // Create SQL query to insert user data into the database
        $sql = "INSERT INTO users (name, email, role, password) VALUES ('$name', '$email', '$role', '$password')";

        if ($conn->query($sql) === TRUE) {
            // Registration successful
            echo 'Registration successful';
            // You can redirect the user to a login page or other destination here
        } else {
            $errors['error'] = 'Registration failed: ' . mysqli_error($conn);
        }
    }
}
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Mini Ticketing System - Register</title>
    <!-- Include Materialize CSS via CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        .register-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
        }

        body {
            /* Set background image */
            background-image: url('miniticketingsystem.jpg');
            /* Specify background size and other properties */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            /* Other styles for your login card */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col s12 m6 offset-m3">
                <div class="card register-card">
                    <div class="card-content">
                        <div class="card-title grey-text">Mini Ticketing System</div>
                        <span class="card-title">Register</span>
                        <form action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
                            <div class="red-text"><?php echo $errors['error']; ?></div>
                            <div class="input-field">
                                <input id="name" type="text" name="name" class="validate" value="<?php echo htmlspecialchars($name) ?>">
                                <label for="name">Name</label>
                            </div>
                            <div class="red-text"><?php echo $errors['name']; ?></div>
                            <div class="input-field">
                                <input id="email" type="text" name="email" class="validate" value="<?php echo htmlspecialchars($email) ?>">
                                <label for="email">Email</label>
                            </div>
                            <div class="red-text"><?php echo $errors['email']; ?></div>
                            <div class="input-field">
                                <input id="role" type="text" name="role" class="validate" value="<?php echo htmlspecialchars($role) ?>">
                                <label for="role">Role (admin/user)</label>
                            </div>
                            <div class="red-text"><?php echo $errors['role']; ?></div>
                            <div class="input-field">
                                <input id="password" type="password" name="password" class="validate">
                                <label for="password">Password</label>
                            </div>
                            <div class="red-text"><?php echo $errors['password']; ?></div>
                            <button class="btn waves-effect waves-light" type="submit" name="register">Register</button>
                        </form>
                    </div>
                    <div class="card-action">
                        <p>Already have an account? <a href="login.php">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Materialize JavaScript via CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>

</html>
