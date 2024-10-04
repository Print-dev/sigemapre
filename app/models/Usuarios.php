<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Usuario extends ExecQuery{

  private $pdo;

  public function login($params=[]):array{
    try{
      $sp = parent::execQ("CALL sp_user_login(?)");
      $sp->execute(array($params['usuario']));
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }

  public function getDataUsuario():array{
    try{
      $cmd=parent::execQ("SELECT * FROM v_usuarios");
      $cmd->execute();
      return $cmd->fetchAll(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }

  
  public function asignarResponsables($params=[]):int{
    try{
      $sp = parent::execQ("CALL asignarResponsables(@idresponsable_asignado,?,?,?)");
      $sp->execute(array(
        $params['idorden_trabajo'],
        $params['idresponsable']
      ));
      $response = $this->pdo->query("SELECT @idresponsable_asignado as idresponsable_asignado")->fetch(\PDO::FETCH_ASSOC);
      return (int) $response['idresponsable_asignado'];
    }catch(\Exception $e){
      die($e->getMessage());
      return -1;
    }
  } 
}
//echo (password_hash('contrasena2', PASSWORD_BCRYPT));

//echo json_encode($user->login(['usuario'=>'a.smith']));
//echo password_hash("contrasena2", PASSWORD_BCRYPT);