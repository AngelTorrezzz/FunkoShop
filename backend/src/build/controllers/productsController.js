"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const database_1 = __importDefault(require("../database"));
class ProductsController {
    //CRUD
    list(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const respuesta = yield database_1.default.query('SELECT * FROM productos');
            res.json(respuesta);
        });
    }
    listOne(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const respuesta = yield database_1.default.query('SELECT * FROM productos WHERE productos.id = ?', [id]);
            if (respuesta.length > 0) {
                res.json(respuesta[0]);
                return;
            }
            res.status(404).json({ 'mensaje': 'Producto no encontrado' });
        });
    }
    create(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const resp = yield database_1.default.query("INSERT INTO productos set ?", [req.body]);
            res.json(resp);
        });
    }
    update(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            console.log(req.params, req.body);
            const resp = yield database_1.default.query("UPDATE productos set ? WHERE productos.id = ?", [req.body, id]);
            //req.body;
            res.json(resp);
        });
    }
    delete(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const resp = yield database_1.default.query(`DELETE FROM productos WHERE productos.id = ${id}`);
            res.json(resp);
        });
    }
    getMediaURLs(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            const { id } = req.params;
            const respuesta = yield database_1.default.query('SELECT mediaURL FROM media_productos WHERE media_productos.id_producto = ?', [id]);
            if (respuesta.length > 0) {
                res.json(respuesta);
                return;
            }
            res.status(404).json({ 'mensaje': 'No hay medios asociados a este producto' });
        });
    }
}
const productsController = new ProductsController();
exports.default = productsController;
