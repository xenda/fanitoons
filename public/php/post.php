<?php

$idTshirt = htmlentities($_POST[idTshirt]);

$idShort = htmlentities($_POST[idShort]);

$idZapatillas = htmlentities($_POST[idZapatillas]);

$urlImage = htmlentities($_POST[urlImage]);

$todo = $idTshirt . " ".  $idShort . " ".  $idZapatillas. " ".  $urlImage;


//ESTO ES OBLIGATORIO PARA EL RETORNO A FLASH
echo "todo=" . $todo;

?>