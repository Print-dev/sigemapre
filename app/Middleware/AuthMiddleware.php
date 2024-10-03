<?php

namespace App\Middleware;

use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

class AuthMiddleware
{
    public function __invoke(Request $request, RequestHandler $handler): Response
    {
        // Verifica si la sesión ya está activa antes de iniciarla
        if (session_status() === PHP_SESSION_NONE) {
            session_start(); // Inicia la sesión
        }

        // Verifica si el valor de 'permitido' en la sesión es true
        if (!isset($_SESSION['login']) && $_SESSION['login']['permitido'] !== true) {
            // Si está permitido, continúa con el manejo de la solicitud
            $response = new \Slim\Psr7\Response();
            return $response->withHeader('Location', '/login')->withStatus(302);
        }

        $uri = $request->getUri()->getPath(); 
        $rol = $_SESSION['login']['rol'];

        if ($rol === 'Usuario' && strpos($uri, '/administrador') === 0) {
            $response = new \Slim\Psr7\Response();
            $response->getBody()->write(json_encode(['acceso' => false]));
            return $response->withStatus(403);
        }

        if ($rol === 'Administrador' && strpos($uri, '/usuario') === 0) {
            return $handler->handle($request);
        }
        // Si no está permitido, devuelve una respuesta 403 Forbidden
        return $handler->handle($request);
    }
}
