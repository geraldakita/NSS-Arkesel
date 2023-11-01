<?php

include('sessionTrig.php');
include('db_connect.php');

$ticketCount = $ticketType = "";
$errors = array('ticketCount' => '', 'ticketType' => '');

if (isset($_POST['editticket'])) {
    // Escape SQL chars
    $id_to_edit = mysqli_real_escape_string($conn, $_POST['id_to_edit']);
    // Make SQL query to retrieve regular ticket information
    $sqlRegularTicket = "SELECT * FROM tickets WHERE e_id = $id_to_edit AND ticketType = 'Regular'";
    // Make SQL query to retrieve vip ticket information
    $sqlVIPTicket = "SELECT * FROM tickets WHERE e_id = $id_to_edit AND ticketType = 'VIP'";
    // Make SQL query to retrieve event information
    $sqlEvent = "SELECT * FROM events WHERE id = $id_to_edit";
    // Get the query result
    $resultRegularTicket = mysqli_query($conn, $sqlRegularTicket);
    $resultVIPTicket = mysqli_query($conn, $sqlVIPTicket);
    // Get the query result
    $resultEvent = mysqli_query($conn, $sqlEvent);
    // Fetch result in array format
    $regularTicket = mysqli_fetch_assoc($resultRegularTicket);
    $VIPTicket = mysqli_fetch_assoc($resultVIPTicket);
    $event = mysqli_fetch_assoc($resultEvent);
    $eventid = $event['id'];
}


if (isset($_POST['submit'])) {
    // Retrieve event ID from the form
    $eventid = $_POST['id_to_add'];


    // Make SQL query to retrieve event information
    $sqlEvent = "SELECT * FROM events WHERE id = $eventid";
    // Get the query result
    $resultEvent = mysqli_query($conn, $sqlEvent);
    $event = mysqli_fetch_assoc($resultEvent);
    $eventid = $event['id'];



    // Check ticket count
    if (empty($_POST['ticketCount'])) {
        $errors['ticketCount'] = 'A ticket count is required';
    } else {
        $ticketCount = $_POST['ticketCount'];
        if (!preg_match('/^[1-9]\d*$/', $ticketCount)) {
            $errors['ticketCount'] = 'Enter a valid ticket number';
        }
    }

    // Check ticket type
    if (empty($_POST['ticketType'])) {
        $errors['ticketType'] = 'A ticket type is required';
    } else {
        $ticketType = $_POST['ticketType'];
        if ($ticketType !== 'VIP' && $ticketType !== 'Regular') {
            $errors['ticketType'] = 'Ticket type must be either "VIP" or "Regular"';
        }
    }

    // Checking for errors using array_filter before updating
    if (array_filter($errors)) {
        // Handle errors or display them to the user
    } else {
        $ticketCount = mysqli_escape_string($conn, $_POST['ticketCount']);
        $ticketType = mysqli_escape_string($conn, $_POST['ticketType']);

        // Check if a ticket for this event already exists
        $checkSql = "SELECT * FROM tickets WHERE e_id = $eventid";
        $checkResult = mysqli_query($conn, $checkSql);

        if (mysqli_num_rows($checkResult) > 0) {
            // Update the existing ticket
            $updateSql = "UPDATE tickets SET ticketCount = '$ticketCount' WHERE e_id = $eventid AND ticketType = '$ticketType'";


            //test code
            if (mysqli_query($conn, $updateSql)) {
                header('Location: index.php');
            } else {
                echo 'query error: ' . mysqli_error($conn);
            }
        } else {
            $errors['ticketType'] = "Ticket type '$ticketType' does not exist to be updated";
        }

        //header('Location: index.php');
    }
}
?>

<!DOCTYPE html>
<html>
<?php include('header.php') ?>

<title>Mini Ticketing System - Update Ticket</title>

<section class="container grey-text">
    <h4 class="center">Update Ticket</h4>
    <form class="white" action="<?php echo $_SERVER['PHP_SELF'] ?>" method="POST">
        <input type="hidden" name="id_to_add" value="<?php echo $event['id']; ?>">
        <div class="container center grey-text">
            <?php if ($event) : ?>
                <h4><?php echo $event['eventName']; ?></h4>
                <p>Details: </br> <?php echo $event['eventDetails']; ?></p>
            <?php else : ?>
                <h5>No such ticket exists.</h5>
            <?php endif ?>
        </div>
        <label>Ticket Type</label>
        <input type="text" name="ticketType" value="<?php echo htmlspecialchars($ticketType) ?>">
        <div class="red-text"><?php echo $errors['ticketType']; ?></div>
        <label>Ticket Count</label>
        <input type="text" name="ticketCount" value="<?php echo htmlspecialchars($ticketCount) ?>">
        <div class="red-text"><?php echo $errors['ticketCount']; ?></div>
        <div class="center">
            <input type="submit" name="submit" value="Update" class="btn brand z-depth-0">
        </div>
    </form>
</section>

</html>