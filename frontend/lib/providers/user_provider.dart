import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ventas_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  // _user es una variable privada que almacena el usuario actual.
  UserModel? _user;
  // user es un getter que devuelve el usuario actual.
  UserModel? get user => _user;

  bool isLoading = false;
  int isLoggedIn = 0;
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

  Future<bool> login(UserModel user) async {
    isLoading = true;
    final url = Uri.parse('${getBaseUrl()}/api/login/listOne');

    try {
      final response = await http.post(
        url,
        body: jsonEncode({'nombreUsuario': user.nombreUsuario, 'contrasena': user.contrasena}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _user = user;
        isLoggedIn = 1;
        return true;
      }
    } catch (e) {
      print('Error during login: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }

    return false;
  }

  int isUserLoggedIn() {
    return isLoggedIn;
  }
}
