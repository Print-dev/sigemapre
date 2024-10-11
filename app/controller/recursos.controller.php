<?php

namespace App\Controllers;

use App\Models\Recurso;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Recurso.php';

class RecursoController{
    private $recurso;

    public function __construct()
    {
        $this->recurso = new Recurso();
    }

    public function getAll(Request $req, Response $res, $args){
        $pt = $this->recurso->getAll();
        $res->getBody()->write(json_encode($pt));
        return $res->withHeader('Content-Type', 'application/json');
      }
}
