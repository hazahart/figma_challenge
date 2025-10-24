import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:figma_challenge/utils/custom_alert.dart';
import 'package:flutter/cupertino.dart';
import '../data/airport_database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if(mounted) showCustomAlert(context, 'Error', 'Por favor, completa todos los campos.');
      setState(() => _isLoading = false);
      return;
    }

    try {
      final db = AirportDatabase.instance;
      
      final user = await db.getUserByEmail(email);

      if (user != null && user.password == password) {

        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        if (mounted) {
          showCustomAlert(context, 'Error de inicio de sesión', 'El correo o la contraseña son incorrectos.');
        }
      }
    } catch (e) {
      if (mounted) {
        showCustomAlert(context, 'Error', 'Ocurrió un error: ${e.toString()}');
      }
    }
    
    if (mounted) {
      setState(() => _isLoading = false);
    }
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
                  ElasticIn(
                    duration: Duration(milliseconds: 1000),
                    child: const Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElasticIn(
                    duration: Duration(milliseconds: 1000),
                    delay: Duration(milliseconds: 500),
                    child: const Text(
                      "Inicia sesión",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Campo Email
                  ElasticInRight(
                    duration: Duration(milliseconds: 850),
                    delay: Duration(milliseconds: 1000),
                    child: CupertinoTextField(
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
                        border: Border.all(color: Color(0xFFAAAAAA)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo Contraseña
                  ElasticInRight(
                    duration: Duration(milliseconds: 1000),
                    delay: Duration(milliseconds: 1000),
                    child: CupertinoTextField(
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
                        border: Border.all(color: Color(0xFFAAAAAA)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _isLoading
                      ? const CupertinoActivityIndicator(radius: 15)
                      : ElasticIn(
                        duration: Duration(milliseconds: 1000),
                        delay: Duration(milliseconds: 1250),
                        child: CupertinoButton.filled(
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
                      ),
                  const SizedBox(height: 16),

                  FadeIn(
                    duration: Duration(milliseconds: 1000),
                    delay: Duration(milliseconds: 1500),
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
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

