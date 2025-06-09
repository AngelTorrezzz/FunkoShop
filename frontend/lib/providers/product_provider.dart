import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ventas_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  bool isLoading = false;

  List<ProductModel> products = [];
  List<ProductModel> favoritesProducts = [];

  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://localhost:3000';
    }
  }

  Future<void> getProducts() async {
    isLoading = true;
    //notifyListeners();

    final url = Uri.parse('${getBaseUrl()}/api/products');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        //print('Response: ${response.body}');

        final data = jsonDecode(response.body);

        products = List<ProductModel>.from(
          data.map((product) => ProductModel.fromJson(product)),
        );

        favoritesProducts = products.where((product) => product.isFavorite == 1).toList();

        //print('products: $products');
        //print('favoritesProducts: $favoritesProducts');
      } else {
        products = [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      products = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteProduct(ProductModel product) async {
    final isFavorite = favoritesProducts.any((p) => p.id == product.id);

    try {
      final url = Uri.parse('${getBaseUrl()}/api/products/update/${product.id}');

      final http.Response response;
      if (isFavorite) {
        response = await http.put(url, body: jsonEncode({'id': product.id, 'isFavorite': 0}), headers: {'Content-Type': 'application/json'});
      } else {
        response = await http.put(url, body: jsonEncode({'id': product.id, 'isFavorite': 1}), headers: {'Content-Type': 'application/json'});
      }

      if (response.statusCode == 200) {
        await getProducts(); // Refresh the product list

      } else {
        throw Exception('Failed to toggle favorite status');
      }

    } catch (e) {
      print('Error toggling favorite status: $e');
    } finally {
      notifyListeners();
    }
  }

}
