import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  bool issLoading = false;

  final Map<ProductModel, int> _items = {};

  Map<ProductModel, int> get items => _items;

  int get totalItems => _items.values.fold(0, (sum, quantity) => sum + quantity);

  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://192.168.137.168:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://localhost:3000';
    }
  }

  // Agrega un producto al carrito, incrementando su cantidad si ya existe y no supera la cantidad disponible
  void addToCart(ProductModel product) {
    if (_items.containsKey(product)) {
      final currentQuantity = _items[product]!;
      //print('Current quantity: $currentQuantity');
      //print('Product quantity: ${product.quantity}');
      if (currentQuantity < product.quantity) {
        _items[product] = currentQuantity + 1;
      }
    } else {
      _items[product] = 1;
    }
    notifyListeners();
  }

  // Elimina un producto del carrito, si la cantidad llega a 0, lo elimina completamente y no permite que se eliminen más allá de la cantidad disponible
  void removeFromCart(ProductModel product) {
    if (_items.containsKey(product)) {
      final currentQuantity = _items[product]!;
      if (currentQuantity > 1) {
        _items[product] = currentQuantity - 1;
      } else {
        _items.remove(product);
      }
      notifyListeners();
    }
  }

  // Obtiene la cantidad de un producto en el carrito
  int getQuantity(ProductModel product) {
    return _items[product] ?? 0;
  }

  void removeItem(ProductModel product) {
    if (_items.containsKey(product)) {
      _items.remove(product);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  Future<bool> purchase() async {
    // Simula una compra exitosa
    //await Future.delayed(const Duration(seconds: 2));
    
    issLoading = true;

    final url = Uri.parse('${getBaseUrl()}/api/cart/purchase');

    //print('items: $_items');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'items': _items.entries.map((entry) => {
            'productId': entry.key.id,
            'quantity': entry.value,
          }).toList(),
        }),
        //body: jsonEncode({
        //  'items': _items,
        //})
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error during purchase: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during purchase: $e');
    } finally {
      issLoading = false;
      notifyListeners();
    }
    return false;
  }
}