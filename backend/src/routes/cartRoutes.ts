import { Router } from 'express';

import cartController from '../controllers/cartController';
import { validarToken } from '../middleware/auth';

class CartRoutes {
  public router: Router = Router();

  constructor() {
    this.config();
  }

  config(): void {
    //Endpoints Personalizados
    this.router.put('/purchase', cartController.purchase);
  }
}

const cartRoutes = new CartRoutes();
export default cartRoutes.router;