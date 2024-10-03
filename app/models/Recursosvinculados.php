<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Recursosvinculados extends ExecQuery
{

  public function obtenerRecursosPorTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerRecursosPorTarea(?)");
      $sp->execute(array($params['idtarea']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function insertarRecursoPorTarea($params = []): array
  {
    try {
      $sp = parent::execQ("CALL insertarRecursoPorTarea(?,?,?)");
      $sp->execute(
        array(
          $params['idrecurso'],
          $params['idtarea'],
          $params['cantidad']
        )
      );
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function actualizarRecursoPorTarea($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL actualizarRecursoPorTarea(?,?,?,?)");
      $status = $sp->execute(
        array(
          $params['idrecurso_vinculado'],
          $params['idrecurso'],
          $params['idtarea'],
          $params['cantidad']
        )
      );
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  // METODO DE ELIMIMNAR
  public function eliminarRecursosVinculadosTarea($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL eliminarRecursosVinculadosTarea(?)");
      $status = $sp->execute(array($params['idrecursovinculado']));
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  
}
