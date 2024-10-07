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
        $imagenesSubidas = $req->getUploadedFiles(); // obtener los archivos subidos desde el postman 
        $directorio = $this->container->get('subidas');

        $nombresImagenes = [];

        if (isset($imagenesSubidas['evidencias'])) {
            $evidencias = $imagenesSubidas['evidencias'];
            if (is_array($evidencias)) {
                $contador = 1;
                foreach ($evidencias as $imagenSubida) {
                    if ($imagenSubida->getError() === UPLOAD_ERR_OK) {
                        // se guarda el archivo subido
                        $resultado = $this->moverArchivoSubido($directorio, $imagenSubida);

                        if ($resultado['permitido']) {
                            $nombresImagenes["e" . $contador] = $resultado['filename'];
                            $contador++;
                        } else {
                            $res->getBody()->write(json_encode(['error' => 'Formato de imagen no permitido']));
                            return $res->withHeader('Content-Type', 'multipart/form-data');
                        }
                    }
                }
            } else {
                if ($evidencias->getError() === UPLOAD_ERR_OK) {
                    // se guarda el archivo subido
                    $resultado = $this->moverArchivoSubido($directorio, $evidencias);

                    if ($resultado['permitido']) {
                        $nombresImagenes["e1"] = $resultado['filename'];
                    } else {
                        $res->getBody()->write(json_encode(['error' => 'Formato de imagen no permitido']));
                        return $res->withHeader('Content-Type', 'multipart/form-data');
                    }
                }
            }
        }

        $jsonEvidencias  = json_encode($nombresImagenes);
        /* if (empty($nombresImagenes)) {
            $res->getBody()->write(json_encode(['error' => 'No se subió ninguna imagen válida']));
            return $res->withStatus(400)->withHeader('Content-Type', 'application/json');
        } */

        $datosEnviar = [
            "idordentrabajo"        => $data["idordentrabajo"],
            "idtipodiagnostico"     => $data["idtipodiagnostico"],
            "diagnostico"           => $data["diagnostico"],
            "evidencias"            => $jsonEvidencias
        ];

        $pt = $this->diagnostico->registrarDiagnostico($datosEnviar);
        $res->getBody()->write(json_encode($pt));
        return $res->withHeader('Content-Type', 'multipart/form-data');
    }

    private function moverArchivoSubido($directory, $uploadedFile)
    {
        $permitido = false;
        $formatosPermitidos = ["jpg", "png", "jpeg"];
        $extension = pathinfo($uploadedFile->getClientFilename(), PATHINFO_EXTENSION);
        $i = 0;
        while (($i < count($formatosPermitidos)) && !$permitido) {
            if ($formatosPermitidos[$i] == $extension) {
                $permitido = true;
            }
            $i++;
        }
        if (!in_array($extension, $formatosPermitidos)) {
            return ['permitido' => false, 'filename' => null]; // Formato no permitido
        }

        $basename = bin2hex(random_bytes(8)); // Crear un nombre de archivo único
        $filename = sprintf('%s.%0.8s', $basename, $extension);

        $uploadedFile->moveTo($directory . DIRECTORY_SEPARATOR . $filename);

        return ['permitido' => true, 'filename' => $filename];
    }

    public function obtenerDiagnosticoEvidencias(Request $req, Response $res, $args)
    {
        $idodt = $args['idodt'];
        $idtipodiagnostico = $args['idtipodiagnostico'];

        $datosEnviar = [
            "idodt" => $idodt,
            "idtipodiagnostico" =>  $idtipodiagnostico
        ];

        $pt = $this->diagnostico->obtenerDiagnosticoEvidencias($datosEnviar);
        $res->getBody()->write(json_encode($pt));
        return $res->withHeader('Content-Type', 'application/json');
    }
}
