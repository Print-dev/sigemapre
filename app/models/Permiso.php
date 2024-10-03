<?php 
namespace App\Models;

use App\Models\ExecQuery;

require_once 'ExecQuery.php';


class Permiso extends ExecQuery{

  public function getPermisosPorRol($params=[]):array{
    try {
      $cmd = parent::execQ("SELECT * FROM permisos WHERE idrol=?");
      $cmd->execute(
        array(
          $params['idrol']
        )
      );
      $permisos = $cmd->fetchAll(\PDO::FETCH_ASSOC);
      $result = [];

      foreach ($permisos as $permiso) {
 
        $decodedPermiso = json_decode($permiso['permiso'], true);

 
        $result[] = [
          'idpermiso' => $permiso['idpermiso'],
          'idrol' => $permiso['idrol'],
          'permiso' => $decodedPermiso
        ];
      }

      return $result[0];        
    } catch (\Exception $e) {
      die($e->getCode());
    }
  }


}

//$permiso = new Permiso();

//echo json_encode($permiso->getPermisosPorRol(["idrol"=>2]), JSON_UNESCAPED_UNICODE);




