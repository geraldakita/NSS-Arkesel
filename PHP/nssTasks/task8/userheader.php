<?php

//include('sessionTrig.php');

if(!isset($_SESSION['userid'])){
  header('Location: login.php');
}

$name = $_SESSION['name']?? 'Guest';
$role = $_SESSION['role']?? 'Unknown';

?>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<style type="text/css">
    .brand {
      background: #cbb09c !important;
    }

    .brand-text {
      color: #cbb09c !important;
    }

    form{
      max-width: 460px;
      margin: 20px auto;
      padding: 20px;
    }

    .eventclass{
      width: 100px;
      margin: 40px auto -30px;
      display: block;
      position: relative;
      top: -30px;
    }
    
  </style>
</head>
<body class="grey lighten-4">
  <nav class="white z-depth-0">
    <div class="container">
      <a href="userindex.php" class="brand-logo brand-text">Mini Ticketing System</a>
      <ul id="nav-mobile" class="right hide-on-small-and-down">
        <li class = "grey-text">Hello <?php echo htmlspecialchars($name);?>&nbsp</li>
        <li class = "grey-text">(<?php echo htmlspecialchars($role);?>)</li>
        <li><a href="userindex.php" class="btn brand z-depth-0">Book Ticket</a></li>
        <li><a href="bookedtickets.php" class="btn brand z-depth-0">My Tickets</a></li>
        <li><a href="logout.php" class="btn brand z-depth-0">Logout</a></li>
      </ul>
    </div>
  </nav>
</html>