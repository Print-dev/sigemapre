<?php

namespace App\Controllers;

use App\Models\OrdenTrabajo;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/OrdenTrabajo.php';

class OrdenTrabajoController
{
  private $ordentrabajo;

  public function __construct()
  {
    $this->ordentrabajo = new OrdenTrabajo();
  }

  public function add(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idtarea"   => $data["idtarea"],
      "creado_por"     => $data["creado_por"]
    ];

    $pt = $this->ordentrabajo->add($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
  
  public function obtenerTareaDeOdtGenerada(Request $req, Response $res, $args)
  {
    $pt = $this->ordentrabajo->obtenerTareaDeOdtGenerada(["idodt" => $args['idodt']]);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function verificarTareaInconclusa(Request $req, Response $res, $args)
  {
    $pt = $this->ordentrabajo->verificarTareaInconclusa();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
    
  }
  
  public function obtenerTareasOdt(Request $req, Response $res, $args)
  {
    $borrador = $args['borrador'];
    $pt = $this->ordentrabajo->obtenerTareasOdt(["borrador" => $borrador]);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
    
  }
  
  public function actualizarBorradorOdt(Request $req, Response $res){
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idordentrabajo"   => $data["idordentrabajo"],
      "borrador"     => $data["borrador"]
    ];

    $pt = $this->ordentrabajo->actualizarBorradorOdt($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}
