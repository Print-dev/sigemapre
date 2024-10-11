<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Tarea extends ExecQuery
{

  public function obtenerTareasPorPlanTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerTareasPorPlanTarea(?)");
      $sp->execute(array($params['idplantarea']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function add($params = []): array
  {
    try {
      $sp = parent::execQ("CALL insertarTarea(?,?,?,?,?,?,?,?)");
      $sp->execute(
        array(
          $params['idplantarea'],
          $params['idtipo_prioridad'],
          $params['descripcion'],
          $params['fecha_inicio'],
          $params['fecha_vencimiento'],
          $params['cant_intervalo'],
          $params['frecuencia'],
          $params['idestado']
        ),

      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
      //print_r( $sp->fetchAll(\PDO::FETCH_ASSOC));
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTareaPorId($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerTareaPorId(?)");
      $sp->execute(array($params['idtarea']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  // METODOS DE ACTUALIZAR
  public function actualizarTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL actualizarTarea(?,?,?,?,?,?,?,?)");
      $sp->execute(
        array(
          $params['idtarea'],
          $params['idtipo_prioridad'],
          $params['descripcion'],
          $params['fecha_inicio'],
          $params['fecha_vencimiento'],
          $params['cant_intervalo'],
          $params['frecuencia'],
          $params['idestado']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC); // ME DEVOLVERA EL ULTIMO ID GENERADO
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  //METODO DE ELIMINAR
  public function eliminarTarea($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL eliminarTarea(?)");
      $status = $sp->execute(array($params['idtarea']));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerTareas():array{
    try {
      $sp = parent::execQ("CALL obtenerTareas()");
      $sp->execute();
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }
  
  public function actualizarTareaEstado($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL actualizarTareaEstado(?,?)");
      $status = $sp->execute(array(
        $params['idtarea'],
        $params['idestado']
      ));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }
}
