import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/providers/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventas_app/providers/user_provider.dart';
import 'package:ventas_app/screens/login_screen.dart';
import 'package:ventas_app/screens/products_screen.dart';
import 'package:ventas_app/providers/product_provider.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(
      context,
    );
    final userProvider = Provider.of<UserProvider>(
      context,
    );
    final productProvider = Provider.of<ProductProvider>(
      context,
    );

    final items = cartProvider.items;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: items.isEmpty
          ? Center(child: Text(
            "Carrito vacío",
            style: GoogleFonts.fredoka(fontSize: 32, color: Colors.black)
          ))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final entry = items.entries.elementAt(index);
                final product = entry.key;
                final quantity = entry.value;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      product.imageURL,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      product.name,
                      style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    subtitle: Text(
                      "Club: ${product.club}\nPrecio: \$${product.price.toStringAsFixed(2)}",
                      style: GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cartProvider.removeFromCart(product),
                        ),
                        Text(
                          quantity.toString(),
                          style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cartProvider.addToCart(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cartProvider.removeItem(product),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isNotEmpty
      ? Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 204, 209, 209),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Total a pagar: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Simula la compra y limpia el carrito
                    if (userProvider.isUserLoggedIn() == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Debes iniciar sesión para comprar.",
                            style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );

                      return;
                    } else {
                      bool success = await cartProvider.purchase();
                      if (success) {
                        productProvider.getProducts();
                        cartProvider.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "¡Compra realizada con éxito!",
                              style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            duration: const Duration(milliseconds: 1750),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Error al realizar la compra.",
                              style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 255, 255, 255)),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.error,
                            duration: const Duration(milliseconds: 1750),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Comprar",
                    style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ],
          ),
        )
      : null,
    );
  }
}
