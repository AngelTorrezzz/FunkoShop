import { Router } from 'express';

import productsController from '../controllers/productsController';
import { validarToken } from '../middleware/auth';

class ProductsRoutes {
  public router: Router = Router();

  constructor() {
    this.config();
  }

  config(): void {
    //Test
    this.router.get('/test', (req, res) => res.send('testeando productos'));

    //Endpoints CRUD
    //this.router.get('/', validarToken, productsController.list);
    //this.router.get('/:id', validarToken, productsController.listOne);
    //this.router.post('/create', validarToken, productsController.create);
    //this.router.put('/update/:id', validarToken, productsController.update);
    //this.router.delete('/delete/:id', validarToken, productsController.delete);

    //Endpoints CRUD
    this.router.get('/', productsController.list);
    this.router.get('/:id', productsController.listOne);
    this.router.post('/create', productsController.create);
    this.router.put('/update/:id', productsController.update);
    this.router.delete('/delete/:id', productsController.delete);

    //Endpoints Personalizados
    this.router.get('/getMediaURLs/:id', productsController.getMediaURLs);
  }
}

const productsRoutes = new ProductsRoutes();
export default productsRoutes.router;