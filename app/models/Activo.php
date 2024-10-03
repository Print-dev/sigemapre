<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Activo extends ExecQuery{

    public function getAll($params = []):array{
        try {
            $cmd = parent::execQ("CALL obtenerActivos(?)");
            $cmd->execute(array(
              $params['idcategoria']
            ));
            return $cmd->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            die($e->getMessage());
        }
    }

  public function add($params=[]):bool{
    try{
      $status=false;
      $cmd = parent::execQ("INSERT INTO activos(idcategoria, idmarca, modelo, cod_identificacion, fecha_adquisicion, descripcion, especificaciones) 
              VALUES(?,?,?,?,?,?,?)");
      $status=$cmd->execute(
        array(
          $params['idcategoria'],
          $params['idsubcategoria'],
          $params['idmarca'],
          $params['modelo'],
          $params['cod_identificacion'],
          $params['fecha_adquisicion'],
          $params['descripcion'],
          $params['especificaciones']
        )
      );
      return $status;
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }

  
}