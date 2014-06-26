<?php

define ("FILEREPOSITORY","./");
$allowedExts = array("c" , "cpp");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);

if (($_FILES["file"]["size"] < 20000) && in_array($extension, $allowedExts)){
        if ($_FILES["file"]["error"] > 0){
            echo "Return Code: " . $_FILES["file"]["error"] . "<br>";
        }else{
             // echo "Ficheiro Upado: " . $_FILES["file"]["name"] . "<br>";
            //  echo "Tipo: " . $_FILES["file"]["type"] . "<br>";
             // echo "Tamanho: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
             // echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br>";

            if (file_exists(FILEREPOSITORY. $_FILES["file"]["name"])){
                              echo $_FILES["file"]["name"] . " already exists. ";
                      }else{
                              move_uploaded_file($_FILES["file"]["tmp_name"], FILEREPOSITORY.$_FILES["file"]["name"]);
                      }
              }
              //$comando="./testrunner.sh " . $_FILES["file"]["name"];     
             
              //$output = system($comando);
              //echo $output;
		$comando="./testrunner.sh " . $_FILES["file"]["name"]; 

                $output = system($comando);
              	echo $output;

  }else{
  echo "Ficheiro Inválido";
  }
?>
