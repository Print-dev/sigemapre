<?php

namespace App\Controllers;

use App\Models\Tipoprioridad;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Tipoprioridad.php';

class TipoPrioridadController{
  private $tprioridad;

  public function __construct()
  {
      $this->tprioridad = new Tipoprioridad();
  }

  public function getAll(Request $req, Response $res){
    $pt = $this->tprioridad->getAll();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

}