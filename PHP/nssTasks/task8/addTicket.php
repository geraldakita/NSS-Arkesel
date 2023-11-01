<?php

include('sessionTrig.php');
include('db_connect.php');

$ticketCount = $ticketType = "";
$errors = array('ticketCount' => '', 'ticketType' => '');
$event = array();

if (isset($_POST['addticket'])) {
    // escape sql chars
    $id_to_add = mysqli_real_escape_string($conn, $_POST['id_to_add']);

    // make sql
    $sql = "SELECT * FROM events WHERE id = $id_to_add";

    // get the query result
    $result = mysqli_query($conn, $sql);

    // fetch result in array format
    $event = mysqli_fetch_assoc($result);
    $eventid = $event['id'];
}

if (isset($_POST['submit'])) {
    // Retrieve event ID from the form
    $eventid = $_POST['id_to_add'];

    // make sql
    $sql = "SELECT * FROM events WHERE id = $eventid";

    // get the query result
    $result = mysqli_query($conn, $sql);

    // fetch result in array format
    $event = mysqli_fetch_assoc($result);
    $eventid = $event['id'];

    // check ticket count
    if (empty($_POST['ticketCount'])) {
        $errors['ticketCount'] = 'A ticket count is required';
    } else {
        $ticketCount = $_POST['ticketCount'];
        if (!preg_match('/^[1-9]\d*$/', $ticketCount)) {
            $errors['ticketCount'] = 'Enter a valid ticket Number';
        }
    }

    // check ticket type
    if (empty($_POST['ticketType'])) {
        $errors['ticketType'] = 'A ticket type is required';
    } else {
        $ticketType = $_POST['ticketType'];
        if ($ticketType !== 'VIP' && $ticketType !== 'Regular') {
            $errors['ticketType'] = 'Ticket type must be either "VIP" or "Regular"';
        }
    }

    // Check if ticket of this type already exists for this event
    $checkSql = "SELECT * FROM tickets WHERE e_id = $eventid AND ticketType = '$ticketType'";
    $checkResult = mysqli_query($conn, $checkSql);
    if (mysqli_num_rows($checkResult) > 0) {
        $errors['ticketType'] = "Ticket of type '$ticketType' already exists for this event. Please use the edit ticket function.";
    }

    if (!array_filter($errors)) {
        $ticketCount = mysqli_escape_string($conn, $_POST['ticketCount']);
        $ticketType = mysqli_escape_string($conn, $_POST['ticketType']);

        $sql1 = "INSERT INTO tickets(e_id, ticketCount, ticketType) VALUES ($eventid,'$ticketCount','$ticketType')";

        if (mysqli_query($conn, $sql1)) {
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
    <form class="white" action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
        <input type="hidden" name="id_to_add" value="<?php echo $event['id']; ?>">
        <div class="container center grey-text">
            <?php if ($event) : ?>
                <h4><?php echo $event['eventName']; ?></h4>
                <p>Details: </br> <?php echo $event['eventDetails']; ?></p>
            <?php else : ?>
                <h5>No such event exists.</h5>
            <?php endif ?>
        </div>
        <label>Ticket Type</label>
        <input type="text" name="ticketType" value="<?php echo htmlspecialchars($ticketType) ?>">
        <div class="red-text"><?php echo $errors['ticketType']; ?></div>
        <label>Ticket Count</label>
        <input type="text" name="ticketCount" value="<?php echo htmlspecialchars($ticketCount) ?>">
        <div class="red-text"><?php echo $errors['ticketCount']; ?></div>
        <div class="center">
            <input type="submit" name="submit" value="Submit" class="btn brand z-depth-0">
        </div>
    </form>
</section>

</html>