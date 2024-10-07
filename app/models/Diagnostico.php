<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Diagnostico extends ExecQuery
{

  // FUTUROS METODOS

  public function registrarDiagnostico($params = []): bool
  {
    try {
      $status = false;
      $sp = parent::execQ("CALL registrarDiagnostico(?,?,?,?)");
      $status = $sp->execute(
        array(
          $params['idordentrabajo'],
          $params['idtipodiagnostico'],
          $params['diagnostico'],
          $params['evidencias']
        )
      );
      return $status;
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }

  public function obtenerDiagnosticoEvidencias($params = []): array
  {
    try {
      $sp = parent::execQ("CALL obtenerDiagnosticoEvidencias(?,?)");
      $sp->execute(array(
        $params['idodt'],
        $params['idtipodiagnostico']
      ));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\Exception $e) {
      die($e->getMessage());
    }
  }
}
