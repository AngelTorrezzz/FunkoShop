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
class CartController {
    purchase(req, res) {
        return __awaiter(this, void 0, void 0, function* () {
            //const {userId, products} = req.body;
            //try {
            //  // Insert the purchase into the purchases table
            //  const purchaseResult = await pool.query('INSERT INTO purchases (user_id) VALUES (?)', [userId]);
            //  const purchaseId = purchaseResult.insertId;
            //
            //  // Insert each product into the purchase_products table
            //  for (const product of products) {
            //    await pool.query('INSERT INTO purchase_products (purchase_id, product_id, quantity) VALUES (?, ?, ?)', [purchaseId, product.id, product.quantity]);
            //  }
            //
            //  res.status(201).json({message: 'Purchase successful', purchaseId});
            //} catch (error) {
            //  console.error(error);
            //  res.status(500).json({message: 'Error processing purchase'});
            //}
            // Solo resta el campo quantity de cada producto
            const { items } = req.body;
            //console.log(items);
            //console.log('Processing purchase...');
            try {
                // Insert each product into the purchase_products table
                for (const item of items) {
                    const { productId, quantity } = item;
                    console.log(`product: ${productId}, quantity: ${quantity}`);
                    yield database_1.default.query('UPDATE productos SET quantity = quantity - ? WHERE id = ?', [quantity, productId]);
                }
                res.status(200).json({ message: 'Purchase successful' });
            }
            catch (error) {
                console.error(error);
                res.status(500).json({ message: 'Error processing purchase' });
            }
        });
    }
}
const cartController = new CartController();
exports.default = cartController;
