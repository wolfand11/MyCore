<?php
	$separator = "-----------------------------------------------------------------------------\n";
	$systemTime = date("Y-m-d H:i:s");
	$requestStr = print_r($_REQUEST, true);
	$postStr = print_r($_POST, true);
	$getStr = print_r($_GET, true);
	$outputStr = $systemTime . $separator . 
				 "requestStr:" . $requestStr . 
				 "postStr:" . $postStr . 
				 "getStr:" . $getStr;
	file_put_contents("Log.txt", $outputStr, FILE_APPEND);
	
	echo $outputStr;
?>