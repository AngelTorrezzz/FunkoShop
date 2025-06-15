import {Request,Response} from 'express';
import pool from '../database';

class ProductsController{
  //CRUD
  public async list(req: Request, res: Response ): Promise<void>{
    const respuesta = await pool.query('SELECT * FROM productos');

    res.json(respuesta);
  }
  
  public async listOne(req: Request, res: Response): Promise <void>{
    const {id} = req.params;
    const respuesta = await pool.query('SELECT * FROM productos WHERE productos.id = ?', [id]);
    
    if(respuesta.length>0){
      res.json(respuesta[0]);
      return ;
    }

    res.status(404).json({'mensaje': 'Producto no encontrado'});
  }

  public async create(req: Request, res: Response): Promise<void> {
    const resp = await pool.query("INSERT INTO productos set ?", [req.body]);
    res.json(resp);
  }  
  
  public async update(req: Request, res: Response): Promise<void> {
    const { id } = req.params;
    console.log(req.params, req.body);
    const resp = await pool.query("UPDATE productos set ? WHERE productos.id = ?", [req.body, id]);
    //req.body;
    res.json(resp);
  }

  public async delete(req: Request, res: Response): Promise<void> {
    const { id } = req.params;
    const resp = await pool.query(`DELETE FROM productos WHERE productos.id = ${id}`);
    res.json(resp);
  }

  public async getMediaURLs(req: Request, res: Response): Promise<void> {
    const { id } = req.params;
    const respuesta = await pool.query('SELECT mediaURL FROM media_productos WHERE media_productos.id_producto = ?', [id]);
    
    if(respuesta.length > 0){
      res.json(respuesta);
      return;
    }

    res.status(404).json({'mensaje': 'No hay medios asociados a este producto'});
  }
}

const productsController = new ProductsController();
export default productsController;