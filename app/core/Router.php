<?php


// ******************************************* IMPORTACIONES ************************************************ 


use Slim\Factory\AppFactory;
use Slim\Views\TwigMiddleware;
use Slim\Psr7\Response as Response;
use Slim\Psr7\Request as Request;

use App\Middleware\RutasMiddleware;
use App\Middleware\AuthMiddleware;

use App\Controllers\UsuarioController;
use App\Controllers\PlandetareasController;
use App\Controllers\RecursoController;
use App\Controllers\ActivoController;
use App\Controllers\ActivosvinculadosController;
use App\Controllers\CategoriaController;
use App\Controllers\EstadosController;
use App\Controllers\OrdenTrabajoController;
use App\Controllers\RecursosvinculadosController;
use App\Controllers\TareasController;
use App\Controllers\TipoPrioridadController;

require_once __DIR__ . '/../Middleware/RutasMiddleware.php';
require_once __DIR__ . '/../Middleware/AuthMiddleware.php';
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/Container.php';
require_once __DIR__ . '/../controller/usuario.controller.php';
require_once __DIR__ . '/../controller/plandetareas.controller.php';
require_once __DIR__ . '/../controller/recursos.controller.php';
require_once __DIR__ . '/../controller/activos.controller.php';
require_once __DIR__ . '/../controller/tareas.controller.php';
require_once __DIR__ . '/../controller/tipoprioridad.controller.php';
require_once __DIR__ . '/../controller/estados.controller.php';
require_once __DIR__ . '/../controller/recursosvinculados.controller.php';
require_once __DIR__ . '/../controller/activosvinculados.controller.php';
require_once __DIR__ . '/../controller/categorias.controller.php';
require_once __DIR__ . '/../controller/ordentrabajo.controller.php';


// ************************************************************************************************************

AppFactory::setContainer($container); // ASIGNAMOS EL CONTENEDOR
$app = AppFactory::create();          //CREAMOS LA APP LISTA PARA SER ENRUTADA

//LLAMANDO A LOS CONTENEDORES
$app->add(TwigMiddleware::createFromContainer($app, 'dashboard')); //LLAMANDO A LA CARPETA QUE TENDRA EL MODULO DASHBOARD
$app->add(TwigMiddleware::createFromContainer($app, 'activos')); //LLAMANDO A LA CARPETA QUE TENDRA EL MODULO ACTIVOS Y SUS SUBMODULOS
$app->add(TwigMiddleware::createFromContainer($app, 'tareas')); //LLAMANDO A LA CARPETA QUE TENDRA EL MODULO TAREAS Y SUS SUBMODULOS
$app->add(TwigMiddleware::createFromContainer($app, 'usuarios')); //LLAMANDO A LA CARPETA QUE TENDRA EL MODULO USUARIOS Y SUS SUBMODULOS
$app->add(TwigMiddleware::createFromContainer($app, 'codstatus')); //LLAMANDO A LA CARPETA QUE TENDRA LOS ERRORES DE UNA PAGINA COMO CODIGO DE ESTADOS
$app->add(TwigMiddleware::createFromContainer($app, 'auth')); //LLAMANDO A LA CARPETA QUE TENDRA LOS ERRORES DE UNA PAGINA COMO CODIGO DE ESTADOS
$app->addBodyParsingMiddleware();

$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);
//$app->add(new Slim\Middleware\MethodOverrideMiddleware());




// ***************************************** R U T A S *********************************************************

$app->group('/usuario', function ($group) {
  $group->get('/dashboard', function (Request $req, Response $res, $args) {
    $view = $this->get('dashboard');

    return $view->render($res, 'dashboard.twig');
  });
  // RUTAS ACTIVOS 
  $group->get('/activos/asignar', function (Request $req, Response $res, $args) {
    $view = $this->get('activos');

    return $view->render($res, 'asignar_activo.twig');
  });

  //RUTAS TAREAS 
  $group->get('/tareas/odt', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');
    return $view->render($res, 'orden_trabajo.twig', ['session' => $_SESSION]);
  });


  $group->get('/tareas/odt/registrar', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');

    return $view->render($res, 'registrarodt.twig');
  });

  // RUTAS PLAN DE TAREAS
  $group->get('/tareas/plantareas', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');
    //print_r($_SESSION['login']['rol']);
    return $view->render($res, 'plan_tareas.twig', ['session' => $_SESSION]);  //cambiado
  });

  //RUTAS PLAN DE TAREAS REGISTRAR
  $group->get('/tareas/plantareas/registrar', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');
    return $view->render($res, 'registrar.twig', ['session' => $_SESSION]); //cambiado
  });

  $group->get('/tareas/plantareas/{idplantarea}', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');
    return $view->render($res, 'actualizar_plan.twig',  ['session' => $_SESSION]); //cambiado
  });

  //RUTAS DE INSERCION
  $group->post('/tareas/plantareas/tarea/registrar', [TareasController::class, 'add']);
  $group->post('/tareas/plantareas/plantarea/registrar', [PlandetareasController::class, 'add']);
  $group->post('/tareas/plantareas/recursosvinculados/registrar', [RecursosvinculadosController::class, 'insertarRecursoPorTarea']);
  $group->post('/tareas/plantareas/activosvinculados/registrar', [ActivosvinculadosController::class, 'insertarActivoPorTarea']);
  $group->post('/usuarios/responsablesasignados/registrar', [UsuarioController::class, 'asignarResponsables']);
  
  //RUTAS DE INSERCION - ODT
  $group->post('/tareas/odt/registrar', [OrdenTrabajoController::class, 'add']);
  //RUTAS DE ACTUALIZACION
  $group->put('/tareas/plantareas/tarea/actualizar', [TareasController::class, 'actualizarTarea']);
  $group->put('/tareas/plantareas/recursosvinculados/actualizar', [RecursosvinculadosController::class, 'actualizarRecursoPorTarea']);  
  $group->put('/tareas/plantareas/actualizar', [PlandetareasController::class, 'actualizarPlanDeTareas']);
  //RUTAS DE ELIMINACION
  $group->delete('/tareas/plantareas/plantarea/{idplantarea}', [PlandetareasController::class, 'eliminarPlanDeTarea']);
  $group->delete('/tareas/plantareas/tarea/{idtarea}', [TareasController::class, 'eliminarTarea']);
  $group->delete('/tareas/plantareas/recursosvinculados/{idrecursovinculado}', [RecursosvinculadosController::class, 'eliminarRecursosVinculadosTarea']);
  $group->delete('/tareas/plantareas/activosvinculados/{idactivovinculado}', [ActivosvinculadosController::class, 'eliminarActivosVinculadosTarea']);


  //RUTAS USUARIOS
  $group->get('/usuarios/listarusuarios', function (Request $req, Response $res, $args) {
    $view = $this->get('usuarios');

    return $view->render($res, 'lista_usuarios.twig');
  });

  //RUTAS ROLES PERMISOS
  $group->get('/usuarios/rolespermisos', function (Request $req, Response $res, $args) {
    $view = $this->get('usuarios');

    return $view->render($res, 'roles_permisos.twig');
  });
})->add(AuthMiddleware::class);

$app->group('/administrador', function ($group) {
  $group->get('/dashboard', function (Request $req, Response $res, $args) {
    $view = $this->get('dashboard');

    return $view->render($res, 'dashboard.twig');
  });
  $group->get('/activos/asignar', function (Request $req, Response $res, $args) {
    $view = $this->get('activos');

    return $view->render($res, 'asignar_activo.twig');
  });

  //RUTAS TAREAS 
  $group->get('/tareas/odt', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');

    return $view->render($res, 'orden_trabajo.twig');
  });

  $group->get('/tareas/odt/registrar', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');

    return $view->render($res, 'registrarodt.twig');
  });

  $group->get('/tareas/plantareas', function (Request $req, Response $res, $args) {
    $view = $this->get('tareas');

    return $view->render($res, 'plan_tareas.twig');
  });

  //RUTAS USUARIOS
  $group->get('/usuarios/listarusuarios', function (Request $req, Response $res, $args) {
    $view = $this->get('usuarios');

    return $view->render($res, 'lista_usuarios.twig');
  });

  $group->get('/usuarios/rolespermisos', function (Request $req, Response $res, $args) {
    $view = $this->get('usuarios');

    return $view->render($res, 'roles_permisos.twig');
  });
})->add(AuthMiddleware::class);

// RUTA POR DEFECTO
$app->get('/', function (Request $req, Response $res, $args) {
  $view = $this->get('dashboard');

  return $view->render($res, 'dashboard.twig');
})->add(AuthMiddleware::class);

$app->get('/login', function (Request $req, Response $res, $args) {
  $view = $this->get('auth');

  return $view->render($res, 'login.twig');
});

// ****************************** RUTAS DE AUTENTICACION **************************************
$app->post('/login', [UsuarioController::class, 'login']); //ME QUEDE ACA
// ******************** RUTAS DE ACCESO A DATOS ***********************************************
//Registrar, obtener usuarios/responsables
$app->get('/transparenciawsrest/consulta/usuarios/data', [UsuarioController::class, 'getDataUsuario']);
//variado
$app->get('/transparenciawsrest/consulta/plantareas/data', [PlandetareasController::class, 'getAll']);
$app->get('/transparenciawsrest/consulta/recursos/{idcategoria}', [RecursoController::class, 'getAll']);
$app->get('/transparenciawsrest/consulta/activos/{idcategoria}', [ActivoController::class, 'getAll']);
$app->get('/transparenciawsrest/consulta/tprioridades/data', [TipoPrioridadController::class, 'getAll']);
$app->get('/transparenciawsrest/consulta/estados/data', [EstadosController::class, 'getAll']);
// registrar, actualizar plan de tareas
$app->get('/transparenciawsrest/consulta/tareasporplantarea/{idplantarea}', [TareasController::class, 'obtenerTareasPorPlanTarea']); //obtener tareas de un plan de tareas
$app->get('/transparenciawsrest/consulta/plandetareas/inconcluso/{idplantarea}', [PlandetareasController::class, 'verificarPlanInconcluso']);
$app->get('/transparenciawsrest/consulta/recursos/tarea/{idtarea}', [RecursosvinculadosController::class, 'obtenerRecursosPorTarea']); //obtener los recursos asignados a una tarea
$app->get('/transparenciawsrest/consulta/tarea/{idtarea}', [TareasController::class, 'obtenerTareaPorId']);
$app->get('/transparenciawsrest/consulta/activos/plantarea/{idplantarea}', [ActivosvinculadosController::class, 'listarActivosPorTareaYPlan']); // obtener activo de una tarea por plan de tareas
$app->get('/transparenciawsrest/consulta/activosvinculados/{idactivovinculado}', [ActivosvinculadosController::class, 'obtenerUnActivoVinculadoAtarea']); //
$app->get('/transparenciawsrest/consulta/categorias/data', [CategoriaController::class, 'getAll']); //
// registrar, obtener, actualizar odt
$app->get('/transparenciawsrest/consulta/tareas/data', [TareasController::class, 'obtenerTareas']);
$app->get('/transparenciawsrest/consulta/tareaodt/{idodt}', [OrdenTrabajoController::class, 'obtenerTareaDeOdtGenerada']);
$app->get('/transparenciawsrest/consulta/tarea/verificar/data', [OrdenTrabajoController::class, 'verificarTareaInconclusa']);
$app->get('/transparenciawsrest/consulta/tareasodt/data', [OrdenTrabajoController::class, 'obtenerTareasOdt']);

//$app->get('/')

// ***********************************************************************************************************************
// PROBAR EL INTERNAL SERVER ERROR
/* $app->get('/test-error-500', function (Request $request, Response $response, $args) {
  // Provoca un error 500 intencionalmente
  throw new Slim\Exception\HttpInternalServerErrorException($request);
});

$app->get('/test-error-401', function (Request $request, Response $response, $args) {
  // Provoca un error 500 intencionalmente
  throw new Slim\Exception\HttpUnauthorizedException($request);
}); */

//RUTAS ALTERNAS CUANDO OCURREN ERRORES INTERNOS COMO 404, 500, ETC...
$errorMiddleware = $app->addErrorMiddleware(true, true, true); // AÑADIMOS EL ERROR MIDDLEWARE DE SLIM

$customErrorHandler = new RutasMiddleware($container->get('codstatus')); //LLAMAMOS A NUESTRA CLASE PERSONALIZADA ERROR MIDDLEWARE Y EL CONTENEDOR CONTIENE TODAS LAS DEPENDECIAS
$errorMiddleware->setErrorHandler(Slim\Exception\HttpNotFoundException::class, $customErrorHandler); // MANEJAR EL ERROR CUANDO SEA 404 , se llama todo el ::CLASS para referenciar la clase completa
$errorMiddleware->setErrorHandler(Slim\Exception\HttpInternalServerErrorException::class, $customErrorHandler); // MANEJAR EL ERROR CUANDO SEA 505
$errorMiddleware->setErrorHandler(Slim\Exception\HttpUnauthorizedException::class, $customErrorHandler); // MANEJAR EL ERROR CUANDO SEA 401


return $app;
