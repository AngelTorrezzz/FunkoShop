"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const morgan_1 = __importDefault(require("morgan"));
const cors_1 = __importDefault(require("cors"));
const productsRoutes_1 = __importDefault(require("./routes/productsRoutes"));
const loginRoutes_1 = __importDefault(require("./routes/loginRoutes"));
const cartRoutes_1 = __importDefault(require("./routes/cartRoutes"));
class Server {
    constructor() {
        this.app = (0, express_1.default)();
        this.config();
        this.routes();
    }
    config() {
        this.app.set('port', process.env.PORT || 3000);
        this.app.use((0, morgan_1.default)('dev')); //Morgan para ver las peticiones que se hacen al servidor
        this.app.use((0, cors_1.default)()); //Cors para que react pueda acceder al servidor
        this.app.use(express_1.default.json()); //Express para que el servidor pueda entender json
        this.app.use(express_1.default.urlencoded({ extended: false })); //Express para que el servidor pueda entender los datos que se le envian desde un formulario
    }
    routes() {
        this.app.use('/api/products', productsRoutes_1.default);
        this.app.use('/api/login', loginRoutes_1.default);
        this.app.use('/api/cart', cartRoutes_1.default);
    }
    start() {
        this.app.listen(this.app.get('port'), () => {
            console.log('Server on port', this.app.get('port'));
        });
    }
}
const server = new Server();
server.start();
