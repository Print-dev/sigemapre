<?php

namespace App\Controllers;

use App\Models\Activo;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Activo.php';

class ActivoController
{
  private $activo;

  public function __construct()
  {
    $this->activo = new Activo();
  }

  public function getAll(Request $req, Response $res, $args)
  {
    $idcategoria = $args['idcategoria'];
    $datosEnviar = [
      "idcategoria"       => $idcategoria
    ];
    $pt = $this->activo->getAll($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function add(Request $req, Response $res)
  {
    //
  }
}
