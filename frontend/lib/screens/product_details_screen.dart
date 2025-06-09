import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/models/product_model.dart';
import 'package:ventas_app/providers/product_provider.dart';
import 'package:google_fonts/google_fonts.dart';



class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productData});
  final ProductModel productData;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).favoritesProducts.contains(widget.productData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 209, 209),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Detalles del Funko',
          style: GoogleFonts.fredoka(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [

          // Botón para agregar a favoritos
          IconButton(
            onPressed: () async {
              await Provider.of<ProductProvider>(
                context,
                listen: false,
              ).toggleFavoriteProduct(widget.productData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            // icon: Icon(
            //   isFavorite ? Icons.favorite : Icons.favorite_border,
            //   color: Colors.white,
            // ),
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                key: ValueKey<bool>(isFavorite),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(25),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Padding(
              //padding: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Image.network(
                widget.productData.imageURL,
                height: 550,
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
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productData.name,
                  style: GoogleFonts.fredoka(fontSize: 32, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.primary),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  color: Theme.of(context).colorScheme.primary,
                  height: 2,
                  margin: EdgeInsets.only(bottom: 12),
                ),
                Text(
                  "Club: ${widget.productData.club}",
                  style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 5),
                Text(
                  "Precio: \$${widget.productData.price}",
                  style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w500, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                Text(
                  "Disponibles: ${widget.productData.quantity}",
                  style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}