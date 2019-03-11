<?php

foreach ($_FILES as $fk => $fd) {
	//echo '<item id="'.$fd[num].'" title="'.htmlspecialchars($fd[title]).'" date="'.$fd[date].'" category="'.$fd[category].'" news="new" />';
	move_uploaded_file($fd['tmp_name'], $fd['name']);
}
//move_uploaded_file( $_FILES['Filedata']['tmp_name'], $_FILES['Filedata']['name']);
//move_uploaded_file( $_FILES['Filedata2']['tmp_name'], $_FILES['Filedata2']['name']);
//move_uploaded_file( $_FILES['Filedata3']['tmp_name'], $_FILES['Filedata3']['name']);
// move_uploaded_file( $_FILES['Filedata']['tmp_name'], "testfolder/".md5($_FILES['Filedata']['tmp_name']).".jpg");

var_export($_FILES);
echo "\r";
var_export($_POST);

// 소켓 request, response 확인
/*
$request = apache_request_headers();
foreach($request as $request => $values){
	echo $request.":".$values."\r" ;
}

echo "==========================================\r" ;

//echo http_get_request_body();
var_export($_POST);

echo "\r==========================================\r" ;

$response = apache_response_headers();
foreach($response as $response => $values){
	echo $response.":".$values."\r" ;
}
*/
?>

