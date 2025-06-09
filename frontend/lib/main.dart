import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/providers/cart_provider.dart';
import 'package:ventas_app/providers/user_provider.dart';
import 'package:ventas_app/screens/cart_screen.dart';
import 'package:ventas_app/screens/favorites_screen.dart';
import 'package:ventas_app/screens/products_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventas_app/providers/product_provider.dart';
//import 'package:ventas_app/providers/cart_provider.dart';
//import 'package:ventas_app/providers/favorites_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Proyecto - Parcial III',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 162, 217, 203)),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 93, 109, 126), // Fondo general

          scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all(true),
            thumbColor: MaterialStateProperty.all(Color.fromARGB(255, 17, 125, 104)),
            trackColor: MaterialStateProperty.all(Colors.grey[800]),
            thickness: MaterialStateProperty.all(8),
            radius: Radius.circular(10),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const OptionsTabs(title: 'Tienda de Funkos'),
      ),
    );
  }
}

class OptionsTabs extends StatelessWidget {
  final String title;

  const OptionsTabs({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: GoogleFonts.fredoka(fontSize: 30, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.fredoka(fontSize: 14, fontWeight: FontWeight.w400),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list), text: 'Funkos'),
              Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
              Tab(icon: Icon(Icons.shopping_cart), text: 'Carrito'),
            ],
          ),
        ),
        body: TabBarView(children: [ProductsScreen(), FavoritesScreen(), CartScreen()]),
      ),
    );
  }
}
