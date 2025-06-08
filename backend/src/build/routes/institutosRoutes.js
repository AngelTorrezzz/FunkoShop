"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const institutosController_1 = __importDefault(require("../controllers/institutosController"));
const auth_1 = require("../middleware/auth");
class InstitutosRoutes {
    constructor() {
        this.router = (0, express_1.Router)();
        this.config();
    }
    config() {
        //Test
        this.router.get('/test', (req, res) => res.send('testeando institutos'));
        //Endpoints CRUD
        this.router.get('/', auth_1.validarToken, institutosController_1.default.list);
        this.router.get('/:id', auth_1.validarToken, institutosController_1.default.listOne);
        this.router.post('/create', auth_1.validarToken, institutosController_1.default.create);
        this.router.put('/update/:id', auth_1.validarToken, institutosController_1.default.update);
        this.router.delete('/delete/:id', auth_1.validarToken, institutosController_1.default.delete);
        //Endpoints Personalizados
    }
}
const institutosRoutes = new InstitutosRoutes();
exports.default = institutosRoutes.router;
