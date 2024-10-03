<?php

namespace App\Controllers;

use App\Models\Rol;

require_once './models/Rol.php';

$rol = new Rol();

if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'getAll':
      echo json_encode($rol->getAll());
      break;
  }
}