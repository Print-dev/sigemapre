<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Categoria extends ExecQuery{

  public function getAll():array{
    try{
      $sp = parent::execQ("SELECT * FROM categorias");
      $sp->execute();
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }



  // FUTUROS METODOS
}
