<?php
   $db = mysqli_connect('localhost', 'root', '', 'userdata');
   if(!$db){
   echo "Database connection failed";
   }
   $matricule = $_POST['matricule'];
   $date = $_POST['date'];
   $status = $_POST['status'];



   $sql = "SELECT * FROM pointage WHERE matricule = '".$matricule."' AND date = '".$date."'";

   $result = mysqli_query($db,$sql);
   $count = mysqli_num_rows($result);

   if($count == 1){
    echo json_encode("Error");
   }else{
    $insert = "INSERT INTO pointage(matricule,date,status) VALUES('".$matricule."','".$date."','".$status."')";
    $query = mysqli_query($db,$insert);
    		if ($query) {
    			echo json_encode("Success");
    		}
   }
?>