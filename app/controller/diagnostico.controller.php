<?php

namespace App\Controllers;

use App\Models\Diagnostico;
use Slim\Psr7\Request as Request;
use Slim\Psr7\Response as Response;
use Psr\Container\ContainerInterface;


//require_once __DIR__ . '/Container.php';
require_once __DIR__ . '/../models/Diagnostico.php';

class DiagnosticoController
{
    private $diagnostico;
    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->diagnostico = new Diagnostico();
        $this->container = $container;
    }

    public function registrarDiagnostico(Request $req, Response $res)
    {
        $data = $req->getParsedBody(); // DATOS DEL POSTMAN
        //$imagenesSubidas = $req->getUploadedFiles(); // obtener los archivos subidos desde el postman 
        //$directorio = $this->container->get('subidas');

        $datosEnviar = [
            "idordentrabajo"        => $data["idordentrabajo"],
            "idtipodiagnostico"     => $data["idtipodiagnostico"],
            "diagnostico"           => $data["diagnostico"]
        ];

        $pt = $this->diagnostico->registrarDiagnostico($datosEnviar);
        $res->getBody()->write(json_encode($pt));
        return $res->withHeader('Content-Type', 'application/json');
    }

    private function moverArchivoSubido($directory, $uploadedFile)
    {
        // Validar la extensión del archivo
        $permitido = false;
        $formatosPermitidos = ["jpg", "png", "jpeg"];
        $extension = pathinfo($uploadedFile->getClientFilename(), PATHINFO_EXTENSION);

        // Verificar si la extensión es permitida
        if (in_array($extension, $formatosPermitidos)) {
            $permitido = true;
        }

        // Si no es permitido, devolver el error
        if (!$permitido) {
            return ['permitido' => false, 'filename' => null];
        }

        // Crear un nombre único para el archivo
        $basename = bin2hex(random_bytes(8)); // Crear un nombre único
        $filename = sprintf('%s.%0.8s', $basename, $extension);

        // Mover el archivo al directorio indicado
        $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);

        // Devolver el nombre del archivo subido
        return ['permitido' => true, 'filename' => $filename];
    }

    public function registrarEvidenciaDiagnostico(Request $req, Response $res, $args)
    {
        // Obtener el diagnóstico desde los datos del cuerpo (getParsedBody())
        $data = $req->getParsedBody();
        $iddiagnostico = $data['iddiagnostico'];

        // Obtener el archivo de evidencia subido
        $uploadedFiles = $req->getUploadedFiles();
        $uploadedFile = $uploadedFiles['evidencia']; // 'evidencia' es el nombre del input en el formulario
        // Definir el directorio donde se guardarán las imágenes
        $directorio = $this->container->get('subidas'); // Debes tener un contenedor configurado para el directorio
        // Procesar la subida del archivo
        $resultadoSubida = $this->moverArchivoSubido($directorio, $uploadedFile);
        error_log(print_r($resultadoSubida, true));

        // Verificar si la subida fue exitosa
        if ($resultadoSubida['permitido']) {
            // Si el archivo es válido, guardar en la base de datos
            $datosEnviar = [
                "iddiagnostico" => $iddiagnostico,
                "evidencia" => $resultadoSubida['filename'] // Guardar el nombre del archivo subido
            ];

            error_log(print_r($datosEnviar, true));

            // Llamar al modelo para registrar la evidencia
            $resultado = $this->diagnostico->registrarEvidenciaDiagnostico($datosEnviar);

            // Devolver la respuesta en formato JSON
            $res->getBody()->write(json_encode($resultado));
            return $res->withHeader('Content-Type', 'application/json');
        } else {
            // Si la subida falló, devolver un error
            $res->getBody()->write(json_encode(["error" => "Formato de archivo no permitido."]));
            return $res->withStatus(400)->withHeader('Content-Type', 'application/json');
        }
    }

    public function obtenerEvidenciasDiagnostico(Request $req, Response $res, $args)
    {
        $iddiagnostico = $args['iddiagnostico'];
        $pt = $this->diagnostico->obtenerEvidenciasDiagnostico(["iddiagnostico" => $iddiagnostico]);
        $res->getBody()->write(json_encode($pt));
        return $res->withHeader('Content-Type', 'application/json');
    }
}
