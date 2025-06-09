"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const cartController_1 = __importDefault(require("../controllers/cartController"));
class CartRoutes {
    constructor() {
        this.router = (0, express_1.Router)();
        this.config();
    }
    config() {
        //Endpoints Personalizados
        this.router.put('/purchase', cartController_1.default.purchase);
    }
}
const cartRoutes = new CartRoutes();
exports.default = cartRoutes.router;
