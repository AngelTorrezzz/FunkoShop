import {Request,Response} from 'express';
import pool from '../database';

class LoginController{
  public async listOne(req: Request, res: Response): Promise <void>{
    console.log('body', req.body);

    const {nombreUsuario, contrasena} = req.body; // Assuming the id is sent in the body of the request
    const respuesta = await pool.query('SELECT * FROM usuarios WHERE usuarios.nombreUsuario = ? AND usuarios.contrasena = ?', [nombreUsuario, contrasena]);

    if(respuesta.length>0){
      res.json(respuesta[0]);
      return ;
    }

    res.status(404).json({'mensaje': 'Usuario no encontrado'});
  }
}

const loginController = new LoginController();
export default loginController;