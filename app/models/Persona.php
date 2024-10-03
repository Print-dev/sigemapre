<?php 
namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Persona extends ExecQuery{

  public function getPersona():array{
    try{
      $sp = parent::execQ("SELECT * FROM v_personas");
      $sp->execute();
      return $sp->fetchAll(\PDO::FETCH_ASSOC);
    }catch(\Exception $e){
      die($e->getMessage());
    }
  }
}

// $person = new Persona();

// echo json_encode($person->getPersona());