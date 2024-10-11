<?php

namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';

class Recurso extends ExecQuery{

    public function getAll():array{
        try {
            $cmd = parent::execQ("CALL obtenerRecursos()");
            $cmd->execute();
            return $cmd->fetchAll(\PDO::FETCH_ASSOC);
        } catch (\Exception $e) {
            die($e->getMessage());
        }
    }

    
}