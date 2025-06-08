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
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const dotenv_1 = __importDefault(require("dotenv"));
//import bcrypt from 'bcrypt';
class LoginController {
    validateCredentials(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            dotenv_1.default.config();
            const TOKEN_SECRET = process.env.TOKEN_SECRET || 'posnes2025';
            const { correo, password } = req.body;
            if (!correo || !password) {
                res.status(400).json({ message: 'Correo y contraseña son requeridos' });
                return;
            }
            try {
                //Formateo del correo
                let formattedCorreo = correo;
                /*
                if (correo.endsWith('@gmail.com')) {
                  // Elimina el dominio @gmail.com
                  formattedCorreo = correo.replace('@gmail.com', '');
                } else if (correo.endsWith('@gs.utm.mx')) {
                  // Reemplaza @gs.utm.mx con @mixteco.utm.mx
                  formattedCorreo = correo.replace('@gs.utm.mx', '');
                } else if (correo.endsWith('@mixteco.utm.mx')) {
                  // Elimina el dominio @mixteco.utm.mx
                  formattedCorreo = correo.replace('@mixteco.utm.mx', '');
                }
                */
                //Consulta SQL
                const rows = yield database_1.default.query('SELECT * FROM profesores WHERE correo = ?', [correo]);
                if (rows.length === 0) {
                    res.status(401).json({ message: 'Correo o contraseña incorrectos' });
                    return;
                }
                //Verificación de la contraseña con bcrypt
                //const passwordMatch = await bcrypt.compare(password, rows[0].password);
                let passwordMatch;
                if (password === rows[0].password) {
                    passwordMatch = true;
                }
                else {
                    passwordMatch = false;
                }
                if (!passwordMatch) {
                    res.status(401).json({ message: 'Contraseña incorrecta' });
                    return;
                }
                //Redirección según el nivel del usuario
                let redirectUrl = '';
                switch (rows[0].id_nivel) {
                    case 1:
                        redirectUrl = '/jefatura/inicio';
                        break;
                    case 2:
                        redirectUrl = '/coordinador/inicio';
                        break;
                    case 3:
                        redirectUrl = '/profesor/inicio';
                        break;
                    case 4:
                        redirectUrl = '/servicios_escolares/inicio';
                        break;
                    case 5:
                        redirectUrl = '/estudiante/inicio';
                        break;
                }
                const token = jsonwebtoken_1.default.sign({}, TOKEN_SECRET, { expiresIn: '1h' });
                res.status(200).json({
                    message: 'Autenticación exitosa',
                    user: {
                        id: rows[0].id,
                        nombre: rows[0].nombre,
                        correo: rows[0].correo,
                        nivel: rows[0].id_nivel
                    },
                    redirectUrl,
                    token
                });
            }
            catch (error) {
                console.error(error);
                res.status(500).json({ message: 'Error en el servidor' });
            }
        });
    }
}
const loginController = new LoginController();
exports.default = loginController;
