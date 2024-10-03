<?php

use App\Config\Conexion;

require_once '../config/Conexion.php';

class Diagnostico extends Conexion{

  private $pdo;

  public function __construct()
  {
    $this->pdo = parent::getConexion();
  }
  //
  public function getALL(){
    $sp = $this->pdo->prepare("SELECT * FROM estados");
    $sp->execute();
    print_r( $sp->fetchAll(\PDO::FETCH_ASSOC));
    print_r($this->pdo->lastInsertId());
  }
  // FUTUROS METODOS
}

$a = new Diagnostico();
$a->getALL();