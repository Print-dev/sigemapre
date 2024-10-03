<?php

namespace App\Controllers;

use App\Models\Activosvinculados;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Activosvinculados.php';

class ActivosvinculadosController
{
  private $activosvinculados;

  public function __construct()
  {
    $this->activosvinculados = new Activosvinculados();
  }

  public function insertarActivoPorTarea(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idactivo"   => $data["idactivo"],
      "idtarea"     => $data["idtarea"]
    ];

    $pt = $this->activosvinculados->insertarActivoPorTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }


  public function listarActivosPorTareaYPlan(Request $req, Response $res, $args)
  {
    $idplantarea = $args['idplantarea'];
    $datosEnviar = [
      "idplantarea" => $idplantarea
    ];

    $pt = $this->activosvinculados->listarActivosPorTareaYPlan($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function obtenerUnActivoVinculadoAtarea(Request $req, Response $res, $args)
  {
    $idactivo_vinculado = $args['idactivovinculado'];
    $datosEnviar = [
      "idactivovinculado" => $idactivo_vinculado
    ];

    $pt = $this->activosvinculados->obtenerUnActivoVinculadoAtarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function eliminarActivosVinculadosTarea(Request $req, Response $res, $args)
  {
    $idactivovinculado = $args['idactivovinculado'];

    $datosEnviar = [
      "idactivovinculado"       => $idactivovinculado
    ];

    $pt = $this->activosvinculados->eliminarActivosVinculadosTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}
