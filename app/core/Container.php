<?php

use DI\Container;
use Slim\Views\Twig;
use App\Middleware\AuthMiddleware;


require_once __DIR__ . '/../../vendor/autoload.php';

$container = new Container();

// CREAR LOS CONTENEDORES DE SERVICIO 

// ASIGNAR UN CONTENEDOR PARA MI CARPETA DE IMAGENES SUBIDAS 
$container->set('subidas', __DIR__ . '/../../public/img/subidas');

$container->set('dashboard', function() {
  return Twig::create(__DIR__ . '/../../public/views/dashboard', ['cache' => false]);
});

$container->set('activos', function() {
  return Twig::create(__DIR__ . '/../../public/views/activos', ['cache' => false]);
});

$container->set('tareas', function() {
  return Twig::create(__DIR__ . '/../../public/views/tareas', ['cache' => false]);
});

$container->set('usuarios', function() {
  return Twig::create(__DIR__ . '/../../public/views/usuarios', ['cache' => false]);
});

$container->set('codstatus', function() {
  return Twig::create(__DIR__ . '/../../public/views/codstatus', ['cache' => false]);
});

$container->set('auth', function() {
  return Twig::create(__DIR__ . '/../../public/views/auth', ['cache' => false]);
});

$container->set(AuthMiddleware::class, function() {
  return new AuthMiddleware();
});


return $container;