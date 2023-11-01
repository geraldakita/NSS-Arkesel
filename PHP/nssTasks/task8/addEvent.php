<?php

include('db_connect.php');

$eventName = $eventDetails = "";
$errors = array('eventName' => '', 'eventDetails' => '');

if(isset($_POST['submit'])){

    // check event name
    if (empty($_POST['eventName'])) {
        $errors['eventName'] = 'An event name is required';
    }
    else{
        $eventName = $_POST['eventName'];
    }

    // check event details
    if (empty($_POST['eventDetails'])) {
        $errors['eventDetails'] = 'Event details are required';
    }
    else{
        $eventDetails = $_POST['eventDetails'];
    }

    //checking for errors using array filter before redirecting
    if (array_filter($errors)) {
        //echo 'errors in the form';
    } else {
        $eventName = mysqli_escape_string($conn, $_POST['eventName']);
        $eventDetails = mysqli_escape_string($conn, $_POST['eventDetails']);

        // create sql
        $sql = "INSERT INTO events(eventName, eventDetails) VALUES('$eventName','$eventDetails')";

        // save to db and check
        if (mysqli_query($conn, $sql)) {
            // success
            header('Location: index.php');
        } else {
            echo 'query error: ' . mysqli_error($conn);
        }
    }
}


?>

<!DOCTYPE html>
<html>
<?php include('header.php') ?>

<title>Mini Ticketing System - Add Event</title>

<section class="container grey-text">
    <h4 class="center">Add an Event</h4>
    <form class="white" action="<?php echo $_SERVER['PHP_SELF']?>" method="POST">
        <label>Event Name</label>
        <input type="text" name="eventName" value="<?php echo htmlspecialchars($eventName) ?>">
        <div class="red-text"><?php echo $errors['eventName']; ?></div>
        <label>Event Details</label>
        <input type="text" name="eventDetails" value="<?php echo htmlspecialchars($eventDetails) ?>">
        <div class="red-text"><?php echo $errors['eventDetails']; ?></div>
        <div class="center">
            <input type="submit" name="submit" value="Submit" class="btn brand z-depth-0">
        </div>
    </form>
</section>

</html>