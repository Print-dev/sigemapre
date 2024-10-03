<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Activosvinculados extends ExecQuery
{

  public function obtenerActivosPorPlanTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerActivosVinculadosPorPlanTarea(?)");
      $sp->execute(array($params['_idplantarea']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function insertarActivoPorTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL insertarActivoPorTarea(?,?)");
      $sp->execute(
        array(
          $params['idactivo'],
          $params['idtarea']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }


  public function listarActivosPorTareaYPlan($params = []): array
  {
    try {
      $sp = parent::execQ("CALL listarActivosPorTareaYPlan(?)");
      $sp->execute(
        array(
          $params['idplantarea']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerUnActivoVinculadoAtarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerUnActivoVinculadoAtarea(?)");
      $sp->execute(
        array(
          $params['idactivovinculado']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  // METODO DE ELIMIMNAR
  public function eliminarActivosVinculadosTarea($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL eliminarActivosVinculadosTarea(?)");
      $status = $sp->execute(array($params['idactivovinculado']));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }
}
