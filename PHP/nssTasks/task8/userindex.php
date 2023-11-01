<?php

include('sessionTrig.php');
include('db_connect.php');

// write query for all events
$sql = 'SELECT * FROM events';

// get the result set (set of rows)
$result = mysqli_query($conn, $sql);

// fetch the resulting rows as an array
$events = mysqli_fetch_all($result, MYSQLI_ASSOC);

// free the $result from memory (good practice)
mysqli_free_result($result);

// Initialize a variable to track the booking status
$bookingStatus = '';

$booking = array('status' => '', 'error' => '');

// Booking Regular ticket
if (isset($_POST['bookregular'])) {
    $e_id = mysqli_real_escape_string($conn, $_POST['event_id']);
    $e_name = mysqli_real_escape_string($conn, $_POST['eventname']);

    // Check if there are available Regular tickets
    $sqlCheckRegular = "SELECT ticketCount FROM tickets WHERE e_id = $e_id AND ticketType = 'Regular'";
    $resultCheckRegular = mysqli_query($conn, $sqlCheckRegular);
    
    if ($resultCheckRegular) {
        $rowCheckRegular = mysqli_fetch_assoc($resultCheckRegular);
        if ($rowCheckRegular && $rowCheckRegular['ticketCount'] > 0) {
            // Decrement the ticket count for Regular
            $sqlDecrementRegular = "UPDATE tickets SET ticketCount = ticketCount - 1 WHERE e_id = $e_id AND ticketType = 'Regular'";
    
            // Insert the booked ticket into the bookedtickets table
            $sql = "INSERT INTO bookedtickets (user_id, e_id, eventName, ticketType) VALUES ({$_SESSION['userid']}, '$e_id', '$e_name', 'Regular')";
    
            // Perform both queries in a transaction
            mysqli_autocommit($conn, false);
    
            if (mysqli_query($conn, $sqlDecrementRegular) && mysqli_query($conn, $sql)) {
                mysqli_commit($conn);
                $bookingStatus = 'Successfully booked Regular ticket for ' . $e_name;
                $booking['status'] = $bookingStatus;
            } else {
                mysqli_rollback($conn);
                echo 'query error: ' . mysqli_error($conn);
            }
    
            mysqli_autocommit($conn, true);
        } else {
            $bookingStatus = 'No available Regular tickets for ' . $e_name;
            $booking['error'] = $bookingStatus;
        }
    } else {
        echo 'query error: ' . mysqli_error($conn);
    }
}

// Booking VIP ticket
if (isset($_POST['bookvip'])) {
    $e_id = mysqli_real_escape_string($conn, $_POST['event_id']);
    $e_name = mysqli_real_escape_string($conn, $_POST['eventname']);

    // Check if there are available VIP tickets
    $sqlCheckVIP = "SELECT ticketCount FROM tickets WHERE e_id = $e_id AND ticketType = 'VIP'";
    $resultCheckVIP = mysqli_query($conn, $sqlCheckVIP);
    
    if ($resultCheckVIP) {
        $rowCheckVIP = mysqli_fetch_assoc($resultCheckVIP);
        if ($rowCheckVIP && $rowCheckVIP['ticketCount'] > 0) {
            // Decrement the ticket count for VIP
            $sqlDecrementVIP = "UPDATE tickets SET ticketCount = ticketCount - 1 WHERE e_id = $e_id AND ticketType = 'VIP'";
    
            // Insert the booked ticket into the bookedtickets table
            $sql = "INSERT INTO bookedtickets (user_id, e_id, eventName, ticketType) VALUES ({$_SESSION['userid']}, '$e_id', '$e_name', 'VIP')";
    
            // Perform both queries in a transaction
            mysqli_autocommit($conn, false);
    
            if (mysqli_query($conn, $sqlDecrementVIP) && mysqli_query($conn, $sql)) {
                mysqli_commit($conn);
                $bookingStatus = 'Successfully booked VIP ticket for ' . $e_name;
                $booking['status'] = $bookingStatus;
            } else {
                mysqli_rollback($conn);
                echo 'query error: ' . mysqli_error($conn);
            }
    
            mysqli_autocommit($conn, true);
        } else {
            $bookingStatus = 'No available VIP tickets for ' . $e_name;
            $booking['error'] = $bookingStatus;
        }
    } else {
        echo 'query error: ' . mysqli_error($conn);
    }
}

?>

<!DOCTYPE html>
<html>
<?php include('userheader.php') ?>
<title>Mini Ticketing System - Tickets On Sale</title>
<h4 class="center grey-text">Tickets On Sale</h4>
<div class=" center green-text"><?php echo $booking['status']; ?></div>
<div class=" center red-text"><?php echo $booking['error']; ?></div>
<div class="container">
    <div class="row">
        <?php foreach ($events as $event) : ?>

            <div class="col s12 m4">
                <div class="card z-depth-0">
                    <img src="ticket.svg" class="eventclass">
                    <div class="card-content center">
                        <h6><?php echo htmlspecialchars($event['eventName']); ?></h6>
                        <ul class="grey-text">
                            <?php foreach (explode('.', $event['eventDetails']) as $det) : ?>
                                <li>
                                    <?php echo htmlspecialchars($det); ?>
                                </li>
                            <?php endforeach ?>
                        </ul>
                        <?php
                        //regular tickets
                        $sqlRegularTicketInfo = "SELECT * FROM tickets WHERE e_id = {$event['id']} AND ticketType = 'Regular'";
                        $resRegularTicketInfo = mysqli_query($conn, $sqlRegularTicketInfo);
                        $regularTickets = mysqli_fetch_assoc($resRegularTicketInfo);
                        //vip tickets
                        $sqlVIPTicketInfo = "SELECT * FROM tickets WHERE e_id = {$event['id']} AND ticketType = 'VIP'";
                        $resVIPTicketInfo = mysqli_query($conn, $sqlVIPTicketInfo);
                        $VIPTickets = mysqli_fetch_assoc($resVIPTicketInfo);
                        ?>
                        <ul class="grey-text">
                            <?php if ($resRegularTicketInfo && mysqli_num_rows($resRegularTicketInfo) > 0) {
                                echo "Number of regular tickets: " . $regularTickets['ticketCount'] . "<br>";
                            } else {
                                echo "Number of regular tickets: 0" . "<br>";
                            }
                            if ($resVIPTicketInfo && mysqli_num_rows($resVIPTicketInfo) > 0) {
                                echo "Number of VIP tickets: " . $VIPTickets['ticketCount'] . "<br>";
                            } else {
                                echo "Number of VIP tickets: 0" . "<br>";
                            }
                            ?>
                        </ul>
                    </div>
                    <div class="card-action right-align" style="display: flex;">

                        <form action="userindex.php" method="POST">
                            <input type="hidden" name="event_id" value="<?php echo $event['id']; ?>">
                            <input type="hidden" name="eventname" value="<?php echo $event['eventName']; ?>">
                            <input type="submit" name="bookregular" value="Book Regular" class="btn brand z-depth-0">
                        </form>
                        <form action="userindex.php" method="POST">
                            <input type="hidden" name="event_id" value="<?php echo $event['id']; ?>">
                            <input type="hidden" name="eventname" value="<?php echo $event['eventName']; ?>">
                            <input type="submit" name="bookvip" value="Book VIP" class="btn brand z-depth-0">
                        </form>
                    </div>
                </div>
            </div>

        <?php endforeach ?>
    </div>
</div>

</html>
