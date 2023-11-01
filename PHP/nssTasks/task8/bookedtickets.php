<?php

include('sessionTrig.php');
include('db_connect.php');

// Query to fetch booked tickets
$sql = "SELECT * FROM bookedtickets WHERE user_id = {$_SESSION['userid']}";

// Get the result set (set of rows)
$result = mysqli_query($conn, $sql);

// Fetch the resulting rows as an array
$bookedTickets = mysqli_fetch_all($result, MYSQLI_ASSOC);

// Free the $result from memory (good practice)
mysqli_free_result($result);

// Deleting the ticket
if (isset($_POST['delete'])) {
    $id_to_delete = mysqli_real_escape_string($conn, $_POST['id_to_delete']);

    // Get the ticket details to identify its type
    $sqlGetTicketType = "SELECT ticketType, e_id FROM bookedtickets WHERE id = $id_to_delete";
    $resultTicketType = mysqli_query($conn, $sqlGetTicketType);
    $rowTicketType = mysqli_fetch_assoc($resultTicketType);

    if (mysqli_query($conn, "DELETE FROM bookedtickets WHERE id = $id_to_delete")) {
        // Deleted from bookedtickets, now increment ticket count
        $ticketType = $rowTicketType['ticketType'];
        $e_id = $rowTicketType['e_id'];

        $sqlIncrementTicket = "UPDATE tickets SET ticketCount = ticketCount + 1 WHERE e_id = $e_id AND ticketType = '$ticketType'";

        if (mysqli_query($conn, $sqlIncrementTicket)) {
            header('Location: bookedtickets.php');
        } else {
            echo 'Error updating ticket count: ' . mysqli_error($conn);
        }
    } else {
        echo 'Error deleting booked ticket: ' . mysqli_error($conn);
    }
}
?>
<!DOCTYPE html>
<html>
<?php include('userheader.php') ?>
<title>Mini Ticketing System - My Booked Tickets</title>
<h4 class="center grey-text">My Booked Tickets</h4>
<div class="container">
    <div class="row">
        <?php foreach ($bookedTickets as $ticket) : ?>
            <div class="col s12 m4">
                <div class="card z-depth-0">
                    <img src="ticket.svg" class="eventclass">
                    <div class="card-content center">
                        <h6>Event: <?php echo htmlspecialchars($ticket['eventName']); ?></h6>
                        <p>Ticket Type: <?php echo htmlspecialchars($ticket['ticketType']); ?></p>
                    </div>
                    <div class="card-action center-align">
                        <form action="bookedtickets.php" method="POST">
                            <input type="hidden" name="id_to_delete" value="<?php echo $ticket['id']; ?>">
                            <input type="submit" name="delete" value="Delete" class="btn brand z-depth-0">
                        </form>
                    </div>
                </div>
            </div>
        <?php endforeach ?>
    </div>
</div>

</html>