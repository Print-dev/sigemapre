<?php

namespace App\Controllers;

use App\Models\Recursosvinculados;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Recursosvinculados.php';

class RecursosvinculadosController{
  private $recursosvinculados;

  public function __construct()
  {
      $this->recursosvinculados = new Recursosvinculados();
  }

  public function insertarRecursoPorTarea(Request $req, Response $res){
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idrecurso"   => $data["idrecurso"],
      "idtarea"     => $data["idtarea"],
      "cantidad"    => $data["cantidad"]
    ];

    $pt = $this->recursosvinculados->insertarRecursoPorTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function obtenerRecursosPorTarea(Request $req, Response $res, $args){
    $idtarea = $args['idtarea'];
    $datosEnviar = [
      "idtarea" => $idtarea
    ];

    $pt = $this->recursosvinculados->obtenerRecursosPorTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  
  public function actualizarRecursoPorTarea(Request $req, Response $res){
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idrecurso_vinculado"   => $data["idrecurso_vinculado"],
      "idrecurso"   => $data["idrecurso"],
      "idtarea"     => $data["idtarea"],
      "cantidad"    => $data["cantidad"]
    ];

    $pt = $this->recursosvinculados->actualizarRecursoPorTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function eliminarRecursosVinculadosTarea(Request $req, Response $res, $args)
  {
    $idrecursovinculado = $args['idrecursovinculado'];

    $datosEnviar = [
      "idrecursovinculado"       => $idrecursovinculado
    ];

    $pt = $this->recursosvinculados->eliminarRecursosVinculadosTarea($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}