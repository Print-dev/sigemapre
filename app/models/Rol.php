<?php
namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';


class Rol extends ExecQuery{

  public function getAll():array{
    try{
      $cmd = parent::execQ("SELECT idrol, rol FROM roles");
      $cmd->execute();
      return $cmd->fetchAll(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }

  public function getByName($params=[]):array{
    try{
      $cmd = parent::execQ("SELECT idrol FROM roles WHERE rol=?");
      $cmd->execute(
        array(
          $params['rol']
        )
      );
      return $cmd->fetch(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }
}
// $rol = new Rol();

// echo json_encode($rol->getByName(['rol'=>'Usuario']));