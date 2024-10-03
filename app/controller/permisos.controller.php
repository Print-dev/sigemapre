<?php

namespace App\Controllers;

use App\Models\Permiso;
use App\Models\Module;
use App\Models\Rol;


require_once '../models/Permiso.php';
require_once '../models/Module.php';
require_once '../models/Rol.php';

$rol = new Rol();
$permiso = new Permiso();
$modulo = new Module();
header("Content-Type: application/json");
$verbo = $_SERVER["REQUEST_METHOD"]; 

//echo json_encode($verbo);
switch($verbo){
  case 'GET':
    $response=[
      'respuesta'=>''
    ];
    if(isset($_GET['rol'])){
      $roles = $rol->getAll();
      $idroles=[];
      #Obtiene la id de cada rol
      foreach($roles as $i=>$elements){
        foreach($elements as $j=>$idrol){
          if($j=="idrol"){
            $idroles[$i]=$idrol;
          }

        }
      }
      $rolByGet = $rol->getByName(['rol'=>$_GET['rol']]);//Obtiene id del rol pasado por GET
      
      if($rolByGet['idrol']>0 && in_array($rolByGet['idrol'], $idroles)){#Valida si la id enviada existe...
        $getPermisos = $permiso->getPermisosPorRol(['idrol'=>$rolByGet['idrol']]);//Obtiene todos los permisos
        //echo json_encode($getPermisos);
        $getModulos = $modulo->getModules($getPermisos['permiso']);
        $response['respuesta']=$getModulos;
        echo json_encode($response);
      }    
    }
    else{
      $response['respuesta']="Hubo un error";
      echo json_encode($response);
    } 
    break;
}

// $getPermisos = $permiso->getPermisosPorRol(['idrol'=>2]);
// //print_r($getPermisos);
// $getModulos = $modulo->getModules($getPermisos['permiso']);
// echo json_encode($getModulos);




