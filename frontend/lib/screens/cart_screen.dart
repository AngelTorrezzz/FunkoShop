import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No hay productos en el carrito.',
        style: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0))
      ),
    );
  }
}
