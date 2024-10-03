<?php
namespace App\Middleware;


use Slim\Views\Twig;
use Slim\Psr7\Response as Response;
use Slim\Psr7\Request as Request;
use Throwable;

//IMPORTAR MANEJADORES DE ERROREs: 
use Slim\Exception\HttpNotFoundException;
use Slim\Exception\HttpInternalServerErrorException;
use Slim\Exception\HttpUnauthorizedException;

class RutasMiddleware
{
    private $twig;

    public function __construct(Twig $twig)
    {
        $this->twig = $twig;
    }

    public function __invoke(Request $request, Throwable $exception, bool $displayErrorDetails, bool $logErrors, bool $logErrorDetails): Response
    {
        $response = new Response();

        switch (get_class($exception)) {
            case HttpNotFoundException::class: // 404
                return $this->twig->render($response->withStatus(404), '404.twig', [
                    'message' => 'Página no encontrada'
                ]);
                break;

            case HttpInternalServerErrorException::class: // 500
                return $this->twig->render($response->withStatus(500), '500.twig', [
                    'message' => 'Error interno del servidor'
                ]);
                break;
            
            case HttpUnauthorizedException::class: // 401
                return $this->twig->render($response->withStatus(401), '401.twig', [
                    'message' => 'Error interno del servidor'
                ]);
                break;


            default: // POR DEFECTO UN 500
                return $this->twig->render($response->withStatus(500), '500.twig', [
                    'message' => 'Error interno del servidor'
                ]);
                break;
        }

    }
}
