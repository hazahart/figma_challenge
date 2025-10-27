import 'package:figma_challenge/models/users_model.dart';
import 'package:figma_challenge/utils/custom_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import '../data/airport_database.dart';
import 'package:figma_challenge/screens/home.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String? _selectedGender;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    setState(() => _isLoading = true);
    final nombre = _nombreController.text;
    final apellidos = _apellidosController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;
    final sexo = _selectedGender;
    final fechaNacimiento = DateFormat('yyyy-MM-dd').format(_selectedDate);

    if (nombre.isEmpty ||
        apellidos.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      if (mounted) {
        showCustomAlert(
          context,
          'Campos incompletos',
          'Por favor, rellena todos los campos obligatorios.',
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    if (password != repeatPassword) {
      if (mounted) {
        showCustomAlert(
          context,
          'Error de contraseña',
          'Las contraseñas no coinciden.',
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    try {
      final db = AirportDatabase.instance;

      final existingUser = await db.getUserByEmail(email);
      if (existingUser != null) {
        if (mounted) {
          showCustomAlert(
            context,
            'Error',
            'El correo electrónico ya está registrado.',
          );
        }
        setState(() => _isLoading = false);
        return;
      }

      final newUser = User(
        nombre: nombre,
        apellidos: apellidos,
        email: email,
        password: password,
        sexo: sexo,
        fechaNacimiento: fechaNacimiento,
      );

      final createdUser = await db.createUser(newUser);

      if (mounted && createdUser.id != null) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => HomeScreen(user: createdUser),
          ),
        );
      } else {
        if (mounted) {
          showCustomAlert(context, 'Error', 'No se pudo crear el usuario.');
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

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                color: CupertinoColors.secondarySystemBackground.resolveFrom(
                  context,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: const Text('Listo'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/wallpaper/back.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  CupertinoColors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 40.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      child: const Text(
                        "Crea tu cuenta",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 500),
                      child: const Text(
                        "Completa tus datos para registrarte",
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 800),
                      child: CupertinoTextField(
                        controller: _nombreController,
                        padding: const EdgeInsets.all(16),
                        placeholder: "Nombre",
                        prefix: _buildIcon(CupertinoIcons.person),
                        decoration: _fieldDecoration(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 900),
                      child: CupertinoTextField(
                        controller: _apellidosController,
                        padding: const EdgeInsets.all(16),
                        placeholder: "Apellidos",
                        prefix: _buildIcon(CupertinoIcons.person_2),
                        decoration: _fieldDecoration(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1000),
                      child: CupertinoTextField(
                        controller: _emailController,
                        padding: const EdgeInsets.all(16),
                        placeholder: "Correo electrónico",
                        keyboardType: TextInputType.emailAddress,
                        prefix: _buildIcon(CupertinoIcons.mail),
                        decoration: _fieldDecoration(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1100),
                      child: CupertinoTextField(
                        controller: _passwordController,
                        padding: const EdgeInsets.all(16),
                        placeholder: "Contraseña",
                        obscureText: true,
                        prefix: _buildIcon(CupertinoIcons.lock),
                        decoration: _fieldDecoration(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1200),
                      child: CupertinoTextField(
                        controller: _repeatPasswordController,
                        padding: const EdgeInsets.all(16),
                        placeholder: "Repetir contraseña",
                        obscureText: true,
                        prefix: _buildIcon(CupertinoIcons.lock),
                        decoration: _fieldDecoration(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1300),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoSegmentedControl<String>(
                          children: const {
                            'M': Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Masculino"),
                            ),
                            'F': Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Femenino"),
                            ),
                          },
                          groupValue: _selectedGender,
                          onValueChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          selectedColor: CupertinoColors.activeBlue,
                          unselectedColor: CupertinoColors.white.withOpacity(
                            0.8,
                          ),
                          borderColor: CupertinoColors.activeBlue,
                          pressedColor: CupertinoColors.activeBlue.withOpacity(
                            0.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElasticIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1400),
                      child: CupertinoButton(
                        onPressed: () => _showDatePicker(context),
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: _fieldDecoration(),
                          child: Row(
                            children: [
                              _buildIcon(CupertinoIcons.calendar),
                              const SizedBox(width: 10),
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                style: const TextStyle(
                                  color: CupertinoColors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    _isLoading
                        ? const CupertinoActivityIndicator(
                            radius: 15,
                            color: CupertinoColors.white,
                          )
                        : ElasticIn(
                            duration: const Duration(milliseconds: 1000),
                            delay: const Duration(milliseconds: 1500),
                            child: CupertinoButton.filled(
                              onPressed: _signUp,
                              borderRadius: BorderRadius.circular(12),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Registrarse",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 16),

                    FadeIn(
                      duration: const Duration(milliseconds: 1000),
                      delay: const Duration(milliseconds: 1700),
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: const Text(
                          "¿Ya tienes cuenta? Inicia sesión",
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
          ),
        ],
      ),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: CupertinoColors.white,
      border: Border.all(color: const Color(0xFFAAAAAA)),
      borderRadius: BorderRadius.circular(14),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Icon(icon, color: CupertinoColors.systemGrey),
    );
  }
}