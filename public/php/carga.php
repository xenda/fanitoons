<?
$id = date("Ymd_His");
move_uploaded_file($_FILES['Filedata']['tmp_name'], "../image/_".$id."_");
echo "_".$id."_";
?>
