"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const productsController_1 = __importDefault(require("../controllers/productsController"));
class ProductsRoutes {
    constructor() {
        this.router = (0, express_1.Router)();
        this.config();
    }
    config() {
        //Test
        this.router.get('/test', (req, res) => res.send('testeando productos'));
        //Endpoints CRUD
        //this.router.get('/', validarToken, productsController.list);
        //this.router.get('/:id', validarToken, productsController.listOne);
        //this.router.post('/create', validarToken, productsController.create);
        //this.router.put('/update/:id', validarToken, productsController.update);
        //this.router.delete('/delete/:id', validarToken, productsController.delete);
        //Endpoints CRUD
        this.router.get('/', productsController_1.default.list);
        this.router.get('/:id', productsController_1.default.listOne);
        this.router.post('/create', productsController_1.default.create);
        this.router.put('/update/:id', productsController_1.default.update);
        this.router.delete('/delete/:id', productsController_1.default.delete);
        //Endpoints Personalizados
    }
}
const productsRoutes = new ProductsRoutes();
exports.default = productsRoutes.router;
