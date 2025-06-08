import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/providers/product_provider.dart';
import 'package:ventas_app/screens/product_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  // Simulamos una lista de productos
  /*final List<Map<String, String>> productos = const [
    {
      'id': '1',
      'name': 'Cristiano Ronaldo',
      'price': '1000.00',
      'club': 'Club deportivo: Al Nassr.',
      'quantity': '5',
      'imageURL': 'assets/images/cristiano.png',
    },
    {
      'id': '2',
      'name': 'Lamine Yamal',
      'price': '450.00',
      'club': 'Club deportivo: FC Barcelona.',
      'quantity': '1',
      'imageURL': 'assets/images/lamine.png',
    },
    {
      'id': '3',
      'name': 'Neymar Jr.',
      'price': '600.00',
      'club': 'Club deportivo: Al Hilal.',
      'quantity': '1',
      'imageURL': 'assets/images/neymar.png',
    },
    {
      'id': '4',
      'name': 'Valverde',
      'price': '400.00',
      'club': 'Club deportivo: Real Madrid.',
      'quantity': '2',
      'imageURL': 'assets/images/valverde.png',
    },
    {
      'id': '5',
      'name': 'Mbappe',
      'price': '450.00',
      'club': 'Club deportivo: Real Madrid.',
      'quantity': '3',
      'imageURL': 'assets/images/mbappe.png',
    },
    {
      'id': '6',
      'name': 'Pedri',
      'price': '400.00',
      'club': 'Club deportivo: FC Barcelona.',
      'quantity': '4',
      'imageURL': 'assets/images/pedri.png',
    },
    {
      'id': '7',
      'name': 'Lionel Messi',
      'price': '999.00',
      'club': 'Club deportivo: Inter Miami.',
      'quantity': '3',
      'imageURL': 'assets/images/messi.png',
    },
    {
      'id': '8',
      'name': 'Erling Haaland',
      'price': '425.00',
      'club': 'Club deportivo: Manchester City.',
      'quantity': '2',
      'imageURL': 'assets/images/haaland.png',
    },
  ];
  */

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    if (productsProvider.products.isEmpty) {
      productsProvider.getProducts();
    }

    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator(),);
          } else if (provider.products.isEmpty) {
            return Center(
              child: Text(
                'No hay funkos disponibles',
                style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              return _productsCard(context, provider.products[index]);
            },
          );
        },
      ),
    );
  }

  Widget _productsCard(BuildContext context, dynamic product) {
    //final colors = Theme.of(context).colorScheme;
    //final cartProvider = Provider.of<CartProvider>(context);
    //final quantity = cartProvider.getQuantity(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Product(productData: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(bottom: 0),
          elevation: 5,
          // El ClipBehavior ayuda a evitar que el contenido se desborde del Card
          clipBehavior: Clip.antiAlias,
          color: Color.fromARGB(255, 204, 209, 209), // Color del Card
          child: Column(
            //crossAxisAlignment sirve para alinear los hijos en el eje transversal
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageURL,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'imageURL no disponible',
                      style: GoogleFonts.fredoka(fontSize: 30, fontWeight: FontWeight.w400, color: const Color.fromARGB(207, 213, 50, 50)),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.fredoka(fontSize: 32, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0))
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Club: ${product.club}',
                      style: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0))
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${product.price}',
                      style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Cantidad: ${product.quantity}',
                      style: GoogleFonts.fredoka(fontSize: 18, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ) 
    );
  }
}