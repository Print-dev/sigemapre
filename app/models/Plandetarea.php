<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Plandetarea extends ExecQuery
{

  public function getPlanesDeTareas()
  {
    try {
      $sp = parent::execQ("CALL obtenerPlantareasDetalles");
      $sp->execute();
      //print_r( $sp->fetchAll(\PDO::FETCH_ASSOC));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function add($params = []): array
  {
    try {
      $sp = parent::execQ("CALL insertarPlanDeTareas(?,?,?)");
      $sp->execute(
        array(
          $params['descripcion'],
          $params['idcategoria'],
          $params['borrador']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC); // ME DEVOLVERA EL ULTIMO ID GENERADO
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function verificarPlanInconcluso($params = [])
  {
    try {
      $sp = parent::execQ("CALL verificarPlanInconcluso(?)");
      $sp->execute(array($params['idplantarea']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC); // ME DEVOLVERA EL ULTIMO ID GENERADO
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function eliminarPlanDeTarea($params = []):bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL eliminarPlanDeTarea(?)");
      $status = $sp->execute(array($params['idplantarea']));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarPlanDeTareas($params = []):bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL actualizarPlanDeTareas(?,?)");
      $status = $sp->execute(array(
        $params['idplantarea'],
        $params['borrador']
      ));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

}
/* 
$p = new Plandetarea();
$p->getPlanesDeTareas(); // ME QUEDE ACA , siguen los demas modelos y sus SP'S  */