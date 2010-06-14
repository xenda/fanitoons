<?php  	$carga = '../image/';	
$uploadFile = $carga . $_FILES['Filedata']['name'];	
move_uploaded_file($_FILES['Filedata']['tmp_name'], $uploadFile);
//chmod($uploadFile, 0777);

echo $uploadFile;
?>
