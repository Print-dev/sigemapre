<?php

namespace App\Controllers;

use App\Models\Categoria;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;


require_once __DIR__ . '/../models/Categoria.php';

class CategoriaController
{
  private $categoria;

  public function __construct()
  {
    $this->categoria = new Categoria();
  }

  public function getAll(Request $req, Response $res)
  {
    $pt = $this->categoria->getAll();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

}
