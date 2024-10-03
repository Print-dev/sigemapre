<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Usuario extends ExecQuery{

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
}
//echo (password_hash('contrasena2', PASSWORD_BCRYPT));

//echo json_encode($user->login(['usuario'=>'a.smith']));
//echo password_hash("contrasena2", PASSWORD_BCRYPT);