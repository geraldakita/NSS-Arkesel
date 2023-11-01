<?php

include('sessionTrig.php');
include('db_connect.php');

$email = $password = $formError = "";
$errors = array('email' => '', 'password' => '', 'error' => '');

if (isset($_POST['login'])) {

    // check email
    if (empty($_POST['email'])) {
        $errors['email'] = 'An email is required';
    } else {
        $email = $_POST['email'];
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = 'Email must be a valid email address';
        }
    }

    // check password
    if (empty($_POST['password'])) {
        $errors['password'] = 'A password is required';
    }
    //else {
    //    $password = $_POST['password'];
    //    if (!preg_match('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.{8,})$/', $password)) {
    //        $errors['password'] = 'Password must be at least 8 characters long and contain at least one lowercase letter, one uppercase letter, and one special character.';
    //    }
    //}

    //checking for errors using array filter before redirecting
    if (array_filter($errors)) {
        //echo 'errors in the form';
    } else {
        // escape sql chars
        $email = mysqli_escape_string($conn, $_POST['email']);
        $password = mysqli_escape_string($conn, $_POST['password']);

        // create sql
        $sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
        $result = $conn->query($sql);
        $userdetails = mysqli_fetch_assoc($result);

        // save to db and check
        if ($result->num_rows > 0 && $userdetails['role']=='admin') {
            header('Location: index.php');
        }
        elseif ($result->num_rows > 0 && $userdetails['role']=='user') {
            header('Location: userindex.php');
        }
         else {
            $errors['error'] = 'Invalid Email/Password';
            echo 'query error: ' . mysqli_error($conn);
        }
        //echo 'form is valid';
        //header('Location: index.php');
        
        //$_SESSION['name'] = 'Gerald';
        //$_SESSION['role'] = 'admin';
        
        $_SESSION['name'] = $userdetails['name'];
        $_SESSION['role'] = $userdetails['role'];
        $_SESSION['userid'] = $userdetails['id'];
    }
}

?>



<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Mini Ticketing System</title>
    <!-- Include Materialize CSS via CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>

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

        .login-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col s12 m6 offset-m3">
                <div class="card login-card">
                    <div class="card-content">
                        <div class="card-title grey-text">Mini Ticketing System</div>
                        <span class="card-title">Login</span>
                        <form action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
                            <div class="red-text"><?php echo $errors['error']; ?></div>
                            <div class="input-field">
                                <input id="email" type="text" name="email" class="validate" value="<?php echo htmlspecialchars($email) ?>">
                                <label for="email">Email</label>
                            </div>
                            <div class="red-text"><?php echo $errors['email']; ?></div>
                            <div class="input-field">
                                <input id="password" type="password" name="password" class="validate">
                                <label for="password">Password</label>
                            </div>
                            <div class="red-text"><?php echo $errors['password']; ?></div>
                            <button class="btn waves-effect waves-light" type="submit" name="login">Login</button>
                        </form>
                    </div>
                    <div class="card-action">
                        <p>New here? <a href="register.php">Register</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include Materialize JavaScript via CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>

</html>