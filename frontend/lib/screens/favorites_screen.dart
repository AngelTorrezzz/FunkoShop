import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No hay productos favoritos.',
        style: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w400, color: const Color.fromARGB(255, 0, 0, 0))
      ),
    );
  }
}