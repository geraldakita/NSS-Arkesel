<?php


include('sessionTrig.php');
include('db_connect.php');


// write query for all events
$sql = 'SELECT * FROM events';

// get the result set (set of rows)
$result = mysqli_query($conn, $sql);

// fetch the resulting rows as an array
$events = mysqli_fetch_all($result, MYSQLI_ASSOC);

// free the $result from memory (good practise)
mysqli_free_result($result);

//deleting the event
if (isset($_POST['delete'])) {

    $id_to_delete = mysqli_real_escape_string($conn, $_POST['id_to_delete']);

    $sql = "DELETE FROM events WHERE id = $id_to_delete";

    if (mysqli_query($conn, $sql)) {
        header('Location: index.php');
    } else {
        echo 'query error: ' . mysqli_error($conn);
    }
}

?>

<!DOCTYPE html>
<html>
<?php include('header.php') ?>
<title>Mini Ticketing System - Events</title>
<h4 class="center grey-text">Events</h4>

<div class="container">
    <div class="row">
        <?php foreach ($events as $event) : ?>

            <div class="col s6 md3">
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
                        <ul class = "grey-text">
                            <?php if(mysqli_num_rows($resRegularTicketInfo)>0){
                               echo "Number of regular tickets: ".$regularTickets['ticketCount']."</br>";
                            } else{
                                echo "Number of regular tickets: 0"."</br>";
                            }if(mysqli_num_rows($resVIPTicketInfo)>0){
                                echo "Number of VIP tickets: ".$VIPTickets['ticketCount']."</br>"; 
                            }else{
                                echo "Number of VIP tickets: 0"."</br>";
                            }
                            ?>
                        </ul>
                    </div>
                    <div class="card-action right-align" style="display: flex;">
                        <form action="addTicket.php" method="POST">
                            <input type="hidden" name="id_to_add" value="<?php echo $event['id']; ?>">
                            <input type="submit" name="addticket" value="Add Ticket" class="btn brand z-depth-0">
                        </form>
                        <form action="editTicket.php" method="POST">
                            <input type="hidden" name="id_to_edit" value="<?php echo $event['id']; ?>">
                            <input type="submit" name="editticket" value="Edit Ticket" class="btn brand z-depth-0">
                        </form>
                        <form action="index.php" method="POST">
                            <input type="hidden" name="id_to_delete" value="<?php echo $event['id']; ?>">
                            <input type="submit" name="delete" value="Delete" class="btn brand z-depth-0">
                        </form>
                    </div>
                </div>
            </div>

        <?php endforeach ?>

    </div>
</div>