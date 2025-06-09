import express, {Application} from 'express';
import morgan from 'morgan';
import cors from 'cors';

import productsRoutes from './routes/productsRoutes';
import loginRoutes from './routes/loginRoutes';
import cartRoutes from './routes/cartRoutes';

class Server {
  public app: Application;
  constructor() {
    this.app= express();
    this.config();
    this.routes();
  }

  config (): void {
    this.app.set('port',process.env.PORT|| 3000);
    this.app.use(morgan('dev'));//Morgan para ver las peticiones que se hacen al servidor
    this.app.use(cors());//Cors para que react pueda acceder al servidor
    this.app.use(express.json());//Express para que el servidor pueda entender json
    this.app.use(express.urlencoded({extended: false}));//Express para que el servidor pueda entender los datos que se le envian desde un formulario
  }

  routes (): void {
    this.app.use('/api/products', productsRoutes);
    this.app.use('/api/login', loginRoutes);
    this.app.use('/api/cart', cartRoutes);
  }

  start (): void {
    this.app.listen(this.app.get('port'), () => {
      console.log('Server on port',this.app.get('port'));
    });
  }
}

const server = new Server();
server.start();