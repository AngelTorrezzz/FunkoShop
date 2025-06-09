import { Router } from 'express';

import loginController from '../controllers/loginController';
import { validarToken } from '../middleware/auth';

class LoginRoutes {
  public router: Router = Router();

  constructor() {
    this.config();
  }

  config(): void {
    //Endpoints Personalizados
    this.router.post('/listOne', loginController.listOne);
  }
}

const loginRoutes = new LoginRoutes();
export default loginRoutes.router;