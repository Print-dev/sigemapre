<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class OrdenTrabajo extends ExecQuery
{

    public function obtenerTareaDeOdtGenerada($params = []): array
    {
        try {
            $cmd = parent::execQ("CALL obtenerTareaDeOdtGenerada(?)");
            $cmd->execute(array(
                $params['idodt']
            ));
            return $cmd->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            die($e->getMessage());
        }
    }

    public function add($params = []): array
    {
        try {
            $cmd = parent::execQ("call registrar_odt(?,?)");
            $cmd->execute(
                array(
                    $params['idtarea'],
                    $params['creado_por']
                )
            );
            return $cmd->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            die($e->getMessage());
        }
    }

    public function verificarTareaInconclusa($params = []): array
    {
        try {
            $cmd = parent::execQ("CALL verificarTareaInconclusa()");
            $cmd->execute();
            return $cmd->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            die($e->getMessage());
        }
    }
}
