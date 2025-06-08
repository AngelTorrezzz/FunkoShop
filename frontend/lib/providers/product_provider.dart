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
        print('Response: ${response.body}');

        final data = jsonDecode(response.body);

        products = List<ProductModel>.from(
          data.map((product) => ProductModel.fromJson(product)),
        );
        
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

  Future<void> toggleFavoriteProducts(ProductModel product) async {
    final isFavorite = favoritesProducts.contains(product);

    try {
      final url = Uri.parse('${getBaseUrl()}/api/favorites');
      final response = 
          isFavorite
              ? await http.delete(url, body: jsonEncode({'id': product.id}))
              : await http.post(url, body: json.encode(product.toJson()));
            
      if (response.statusCode == 200) {
        if (isFavorite) {
          favoritesProducts.remove(product);
        } else {
          favoritesProducts.add(product);
        }

        notifyListeners();

      } else {
        throw Exception('Failed to toggle favorite status');
      }

      notifyListeners();

    } catch (e) {
      print('Error toggling favorite status: $e');
      notifyListeners();
    }
  }

}
