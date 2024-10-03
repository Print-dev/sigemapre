<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Tipoprioridad extends ExecQuery{

  public function getAll():array{
    try{
      $sp = parent::execQ("SELECT * FROM tipo_prioridades");
      $sp->execute();
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
      //print_r( $sp->fetchAll(\PDO::FETCH_ASSOC));
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }



  // FUTUROS METODOS
}
