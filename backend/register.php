<?php
   $db = mysqli_connect('localhost', 'root', '', 'userdata');
   if(!$db){
   echo "Database connection failed";
   }
   $name = $_POST['name'];
   $phonenumber = $_POST['phonenumber'];
   $password = $_POST['password'];
   $matricule = $_POST['matricule'];
   $_depId = $_POST['iddep'];



   $sql = "SELECT * FROM login WHERE phonenumber = '".$phonenumber."' OR matricule = '".$matricule."'";

   $result = mysqli_query($db,$sql);
   $count = mysqli_num_rows($result);

   if($count == 1){
    echo json_encode("Error");
   }else{
    $insert = "INSERT INTO login(name,phonenumber,password,matricule,iddep) VALUES('".$name."','".$phonenumber."','".$password."','".$matricule."','".$_depId."')";
    $query = mysqli_query($db,$insert);
    		if ($query) {
    			echo json_encode("Success");
    		}
   }
?>