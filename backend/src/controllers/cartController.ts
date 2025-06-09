import {Request,Response} from 'express';
import pool from '../database';

class CartController{
  public async purchase(req: Request, res: Response): Promise<void> {
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
        await pool.query('UPDATE productos SET quantity = quantity - ? WHERE id = ?', [quantity, productId]);
      }

      res.status(200).json({message: 'Purchase successful'});
    } catch (error) {
      console.error(error);
      res.status(500).json({message: 'Error processing purchase'});
    }
  }
}

const cartController = new CartController();
export default cartController;