import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ventas_app/providers/user_provider.dart';
import 'package:ventas_app/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventas_app/screens/cart_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Iniciar Sesión",
          style: GoogleFonts.fredoka(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Card(
        margin: const EdgeInsets.only(left: 45.0, right: 45.0, top: 150.0, bottom: 150.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color.fromARGB(255, 204, 209, 209),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool success = await userProvider.login(UserModel(
                    nombreUsuario: _usernameController.text.trim(),
                    contrasena: _passwordController.text,
                  ));
        
                  if (!context.mounted) return;
        
                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Error al iniciar sesión"),
                        backgroundColor: Colors.red,
                        duration: const Duration(milliseconds: 1750),
                      ),
                    );
                  }
                },
                child: Text(
                  "Iniciar Sesión",
                  style: GoogleFonts.fredoka(fontSize: 16, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
