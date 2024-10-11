<?php

namespace App\Controllers;

use App\Models\Tarea;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Tarea.php';

class TareasController
{
  private $tarea;

  public function __construct()
  {
    $this->tarea = new Tarea();
  }

  public function add(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idplantarea"       => $data["idplantarea"],
      "idtipo_prioridad"  => $data['idtipo_prioridad'],
      "descripcion"       => $data["descripcion"],
      "fecha_inicio"      => $data["fecha_inicio"],
      "fecha_vencimiento" => $data["fecha_vencimiento"],
      "cant_intervalo"    => $data["cant_intervalo"],
      "frecuencia"        => $data["frecuencia"],
      "idestado"          => $data["idestado"]
    ];

    $pt = $this->tarea->add($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function obtenerTareasPorPlanTarea(Request $req, Response $res, $args)
  {
    $idplantarea = $args['idplantarea'];
    $datosEnviar = [
      "idplantarea" => $idplantarea
    ];

    $pt = $this->tarea->obtenerTareasPorPlanTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }


  public function obtenerTareaPorId(Request $req, Response $res, $args)
  {
    $idtarea = $args['idtarea'];
    $datosEnviar = [
      "idtarea" => $idtarea
    ];

    $pt = $this->tarea->obtenerTareaPorId($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function actualizarTarea(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idtarea"           => $data["idtarea"],
      "idtipo_prioridad"  => $data['idtipo_prioridad'],
      "descripcion"       => $data["descripcion"],
      "fecha_inicio"      => $data["fecha_inicio"],
      "fecha_vencimiento" => $data["fecha_vencimiento"],
      "cant_intervalo"    => $data["cant_intervalo"],
      "frecuencia"        => $data["frecuencia"],
      "idestado"          => $data["idestado"]
    ];

    $pt = $this->tarea->actualizarTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function eliminarTarea(Request $req, Response $res, $args)
  {
    $idtarea = $args['idtarea'];

    $datosEnviar = [
      "idtarea"       => $idtarea
    ];

    $pt = $this->tarea->eliminarTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  
  public function obtenerTareas(Request $req, Response $res){
    $pt = $this->tarea->obtenerTareas();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function actualizarTareaEstado(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idtarea"           => $data["idtarea"],
      "idestado"  => $data['idestado']
    ];

    $pt = $this->tarea->actualizarTareaEstado($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}
