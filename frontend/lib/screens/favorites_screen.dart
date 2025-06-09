import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/models/product_model.dart';
import 'package:ventas_app/providers/product_provider.dart';
import 'package:ventas_app/screens/product_details_screen.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 109, 126),
      //appBar: AppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          final favoriteProducts = productProvider.favoritesProducts;

          return favoriteProducts.isEmpty
              ? Center(child: Text(
                  "No hay productos favoritos",
                  style: GoogleFonts.fredoka(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.black),
                ))
              : ListView.builder(
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return FavoriteProductsCard(product: product);
                },
              );
        },
      ),
    );
  }
}

class FavoriteProductsCard extends StatelessWidget {
  final ProductModel product;
  const FavoriteProductsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(productData: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          color: Color.fromARGB(255, 204, 209, 209),
          //child: Row(children: [Text(recipe.name), Text(recipe.author)]),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(10)),
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(product.imageURL, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Container(
                    color: colors.primary,
                    height: 2,
                    width: size.width * 0.4,
                  ),
                  SizedBox(height: 6),
                  Text("Club: ${product.club}", style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}