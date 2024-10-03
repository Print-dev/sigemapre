<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Estados extends ExecQuery{

  public function getAll():array{
    try{
      $sp = parent::execQ("SELECT * FROM estados");
      $sp->execute();
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
      //print_r( $sp->fetchAll(\PDO::FETCH_ASSOC));
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }



  // FUTUROS METODOS
}
