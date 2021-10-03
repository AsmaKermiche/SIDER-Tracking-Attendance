<?php

// Creating MySQL Connection.
 $con = mysqli_connect("localhost", "root", "", "userdata");

 // Getting the received ID in JSON Format into $json variable.
 $json = file_get_contents('php://input');

 // Decoding the received JSON.
 $obj = json_decode($json,true);

 // Populate ID from JSON $obj array and store into $ID variable.
 $phone = $obj['phonenumber'];

 //Fetching the selected record as per ID.
 $CheckSQL = "SELECT matricule,iddep FROM login WHERE phonenumber = '$phone'";

 $result = $con->query($CheckSQL);

if ($result->num_rows >0) {

 while($row[] = $result->fetch_assoc()) {

 $Item = $row;

 $json = json_encode($Item, JSON_NUMERIC_CHECK);

 }

}else {

 echo "No Results Found.";

}

echo $json;

$con->close();
?>

