<?php

namespace App\Controllers;

use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;
use App\Models\Usuario;


require_once __DIR__ . '/../models/Usuarios.php';

class UsuarioController
{
  private $user;

  public function __construct()
  {
    $this->user = new Usuario();
  }

  public function login(Request $request, Response $response)
  {
    session_start();
    $login_info_recibida = [
      'permitido' => false,
      'idusuario' => 0,
      'usuario' => '',
      'rol' => '',
      'status' => ''
    ];

    $data = $request->getParsedBody(); //formData // OBTENER LO QUE ESCRIBIMOS EN EL CUERPO DE LA SOLCITUD        

    $row = $this->user->login(['usuario' => $data['usuario']]);

    if (count($row) == 0) {
      $login_info_recibida['status'] = "No existe el usuario";
    } else {
      $claveEncriptada = $row[0]['contrasena'];
      $claveIngreso = $data['passusuario'];

      if (password_verify($claveIngreso, $claveEncriptada)) {
        $login_info_recibida['permitido'] = true;
        $login_info_recibida['idusuario'] = $row[0]['idusuario'];
        $login_info_recibida['usuario'] = $row[0]['usuario'];
        $login_info_recibida['rol'] = $row[0]['rol'];
        $login_info_recibida['status'] = "Credenciales correctas";
      } else {
        $login_info_recibida["status"] = "Contrasenia incorrecta";
      }
    }

    $_SESSION['login'] = $login_info_recibida;

    //error_log(print_r($_SESSION, true));
    // Devolver la respuesta JSON

    $response->getBody()->write(json_encode($login_info_recibida));
    return $response->withHeader('Content-Type', 'application/json');
  }

  public function asignarResponsables(Request $req, Response $res)
  {
    $data = $req->getParsedBody(); // DATOS DEL POSTMAN

    $datosEnviar = [
      "idorden_trabajo"   => $data["idorden_trabajo"],
      "idresponsable"     => $data["idresponsable"]
    ];

    $pt = $this->user->asignarResponsables($datosEnviar);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function getDataUsuario(Request $req, Response $res, $args)
  {
    $pt = $this->user->getDataUsuario();
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }

  public function obtenerUsuario(Request $req, Response $res, $args)
  {
    $idusuario = $args["idusuario"]; // DATOS DEL POSTMAN

    $pt = $this->user->obtenerUsuario(["idusuario" => $idusuario]);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
  
  public function obtenerResponsablesPorOdt(Request $req, Response $res, $args)
  {
    $idorden_trabajo = $args["idorden_trabajo"]; // DATOS DEL POSTMAN

    $pt = $this->user->obtenerResponsablesPorOdt(["idorden_trabajo" => $idorden_trabajo]);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
  
  public function eliminarResponsableOdt(Request $req, Response $res, $args)
  {
    $idresponsableasignado = $args["idresponsableasignado"]; // DATOS DEL POSTMAN

    $pt = $this->user->eliminarResponsableOdt(["idresponsableasignado" => $idresponsableasignado]);
    $res->getBody()->write(json_encode($pt));
    return $res->withHeader('Content-Type', 'application/json');
  }
}

/* session_start();
require_once '../models/Usuarios.php';

$user = new Usuario();

if(isset($_GET['operation'])){
  switch($_GET['operation']){
    case 'login':
      $login=[
        'permitido'=>false,
        'usuario'=>'',
        'rol'=>'',
        'status'=>''
      ];

      $row = $user->login(['usuario'=>$_GET['usuario']]);
      if(count($row)==0){
        $login['status']="No existe el usuario";
      }else{
        $claveEncriptada = $row[0]['contrasena'];
        $claveIngreso = $_GET['passusuario'];

        if(password_verify($claveIngreso, $claveEncriptada)){
          $login['permitido'] = true;
          $login['usuario']=$row[0]['usuario'];
          $login['rol']=$row[0]['rol'];
        }else{
          $login["status"]="Contrasenia incorrecta";
        }
      }

      $_SESSION['login'] = $login;
      echo json_encode($login);
      break;
    case 'destroy':
      session_unset();
      session_destroy();
      header("Location:http://localhost/CMMS");
      break;

    case 'getData':
      echo json_encode($user->getDataUsuario());
      break;
  }
} */