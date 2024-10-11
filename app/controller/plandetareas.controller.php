<?php

namespace App\Controllers;

use App\Models\Plandetarea;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Plandetarea.php';

class PlandetareasController{
  private $plantarea;

  public function __construct()
  {
      $this->plantarea = new Plandetarea();
  }

  public function getAll(Request $req, Response $res){
    $pt = $this->plantarea->getPlanesDeTareas();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function add(Request $req, Response $res){
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "descripcion"       => $data["descripcion"],
      "borrador"          => $data['borrador']
    ];

    $pt = $this->plantarea->add($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function verificarPlanInconcluso(Request $req, Response $res, $args){
    $idplantarea = $args['idplantarea'];
    $datosEnviar = [
      "idplantarea" => $idplantarea
    ];
    $pt = $this->plantarea->verificarPlanInconcluso($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
  
  public function eliminarPlanDeTarea(Request $req, Response $res, $args){
    $idplantarea = $args['idplantarea'];

    $datosEnviar = [
      "idplantarea"       => $idplantarea
    ];

    $pt = $this->plantarea->eliminarPlanDeTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  
  public function actualizarPlanDeTareas(Request $req, Response $res){
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idplantarea"       => $data["idplantarea"],
      "borrador"          => $data['borrador']
    ];

    $pt = $this->plantarea->actualizarPlanDeTareas($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}