<?php

namespace App\Controllers;

use App\Models\Estados;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Estados.php';

class EstadosController{
  private $estados;

  public function __construct()
  {
      $this->estados = new Estados();
  }

  public function getAll(Request $req, Response $res){
    $pt = $this->estados->getAll();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

}