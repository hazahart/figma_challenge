import 'package:flutter/cupertino.dart';

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

  void _signUp() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacementNamed('/home');
    });
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
                    const Text(
                      "Crea tu cuenta",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Completa tus datos para registrarte",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Campo Nombre
                    CupertinoTextField(
                      controller: _nombreController,
                      padding: const EdgeInsets.all(16),
                      placeholder: "Nombre",
                      prefix: _buildIcon(CupertinoIcons.person),
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // Campo Apellidos
                    CupertinoTextField(
                      controller: _apellidosController,
                      padding: const EdgeInsets.all(16),
                      placeholder: "Apellidos",
                      prefix: _buildIcon(CupertinoIcons.person_2),
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // Campo Email
                    CupertinoTextField(
                      controller: _emailController,
                      padding: const EdgeInsets.all(16),
                      placeholder: "Correo electrónico",
                      keyboardType: TextInputType.emailAddress,
                      prefix: _buildIcon(CupertinoIcons.mail),
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // Campo Contraseña
                    CupertinoTextField(
                      controller: _passwordController,
                      padding: const EdgeInsets.all(16),
                      placeholder: "Contraseña",
                      obscureText: true,
                      prefix: _buildIcon(CupertinoIcons.lock),
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // Campo Repetir Contraseña
                    CupertinoTextField(
                      controller: _repeatPasswordController,
                      padding: const EdgeInsets.all(16),
                      placeholder: "Repetir contraseña",
                      obscureText: true,
                      prefix: _buildIcon(CupertinoIcons.lock),
                      decoration: _fieldDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // Campo Sexo
                    SizedBox(
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
                        unselectedColor: CupertinoColors.white.withOpacity(0.8),
                        borderColor: CupertinoColors.activeBlue,
                        pressedColor: CupertinoColors.activeBlue.withOpacity(
                          0.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo Fecha de Nacimiento
                    CupertinoButton(
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
                              // Formato de fecha
                              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                              style: const TextStyle(
                                color: CupertinoColors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botón de Registro
                    _isLoading
                        ? const CupertinoActivityIndicator(
                            radius: 15,
                            color: CupertinoColors.white,
                          )
                        : CupertinoButton.filled(
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
                    const SizedBox(height: 16),

                    // Botón para ir a Login
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Decoración de los campos
  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: CupertinoColors.white,
      border: Border.all(color: const Color(0xFFAAAAAA)),
      borderRadius: BorderRadius.circular(14),
    );
  }

  // Iconos de prefix
  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Icon(icon, color: CupertinoColors.systemGrey),
    );
  }
}
