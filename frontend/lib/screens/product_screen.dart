import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:ventas_app/models/product_model.dart';
//import 'package:ventas_app/providers/product_provider.dart';

class Product extends StatefulWidget {
  final ProductModel productData;

  const Product({super.key, required this.productData});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}