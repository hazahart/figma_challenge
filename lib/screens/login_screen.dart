import 'dart:ui';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // backgroundColor: CupertinoColors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/wallpaper/back.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  CupertinoColors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Inicia sesión",
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Campo Email
                  CupertinoTextField(
                    controller: _emailController,
                    padding: const EdgeInsets.all(16),
                    placeholder: "Correo electrónico",
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        CupertinoIcons.mail,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      border: BoxBorder.all(color: Color(0xFFAAAAAA)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo Contraseña
                  CupertinoTextField(
                    controller: _passwordController,
                    padding: const EdgeInsets.all(16),
                    placeholder: "Contraseña",
                    obscureText: true,
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        CupertinoIcons.lock,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      border: BoxBorder.all(color: Color(0xFFAAAAAA)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _isLoading
                      ? const CupertinoActivityIndicator(radius: 15)
                      : CupertinoButton.filled(
                          onPressed: _login,
                          borderRadius: BorderRadius.circular(12),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 100,
                          ),
                          child: const Text(
                            "Iniciar sesión",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  const SizedBox(height: 16),

                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: const Text(
                      "¿No tienes cuenta? Regístrate",
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
