import 'package:figma_challenge/screens/flight_calendar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:figma_challenge/data/airport_database.dart';
import 'package:figma_challenge/utils/custom_alert.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final Function(User) onProfileUpdated;

  const ProfilePage({
    super.key,
    required this.user,
    required this.onProfileUpdated,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _appearanceValue = 0;
  bool _notifications = true;

  late final TextEditingController _nombreController;
  late final TextEditingController _apellidosController;
  late final TextEditingController _emailController;

  late User _currentUser;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;

    _nombreController = TextEditingController(text: _currentUser.nombre);
    _apellidosController = TextEditingController(text: _currentUser.apellidos);
    _emailController = TextEditingController(text: _currentUser.email);
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      setState(() {
        _currentUser = widget.user;
        _nombreController.text = _currentUser.nombre;
        _apellidosController.text = _currentUser.apellidos;
        _emailController.text = _currentUser.email;
      });
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    final nombre = _nombreController.text.trim();
    final apellidos = _apellidosController.text.trim();

    if (nombre.isEmpty || apellidos.isEmpty) {
      if (mounted) {
        showCustomAlert(context, 'Campos incompletos', 'El nombre y los apellidos no pueden estar vacíos.');
      }
      setState(() => _isSaving = false);
      return;
    }

    try {
      final updatedUser = _currentUser.copyWith(
        nombre: nombre,
        apellidos: apellidos,
      );

      final db = AirportDatabase.instance;
      final rowsAffected = await db.updateUser(updatedUser);

      if (mounted) {
        if (rowsAffected > 0) {
          setState(() {
            _currentUser = updatedUser;
          });
          widget.onProfileUpdated(updatedUser);
          showCustomAlert(context, 'Éxito', 'Tu perfil ha sido actualizado.');
        } else {
          showCustomAlert(context, 'Error', 'No se pudo actualizar el perfil. Intenta de nuevo.');
        }
      }
    } catch (e) {
      if (mounted) {
        showCustomAlert(context, 'Error', 'Ocurrió un error inesperado: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _navigateToCalendar() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => FlightCalendarScreen(user: _currentUser),
      ),
    );
  }

  Future<void> _logout() async {
    final bool? confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Cerrar Sesión"),
        content: const Text("¿Estás seguro de que quieres cerrar tu sesión?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text("Cerrar Sesión"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        '/',
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF2F2F7),
      child: ListView(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.label
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                  child: Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  CupertinoTextField.borderless(
                    controller: _nombreController,
                    placeholder: "Name",
                    padding: const EdgeInsets.all(16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(height: 1),
                  ),
                  CupertinoTextField.borderless(
                    controller: _apellidosController,
                    placeholder: "Surname",
                    padding: const EdgeInsets.all(16),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(height: 1),
                  ),
                  CupertinoTextField.borderless(
                    controller: _emailController,
                    placeholder: "Email",
                    padding: const EdgeInsets.all(16),
                    readOnly: true,
                    style: const TextStyle(
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: const Text(
              "SETTINGS",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Appearance:"),
                        CupertinoSegmentedControl<int>(
                          borderColor: CupertinoColors.systemGrey3,
                          selectedColor: CupertinoColors.white,
                          unselectedColor: CupertinoColors.systemGrey3,
                          pressedColor: CupertinoColors.systemGrey4,
                          children: const {
                            0: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.sun_max_fill,
                                    size: 18,
                                    color: CupertinoColors.black,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Light",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            1: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.moon_fill,
                                    size: 18,
                                    color: CupertinoColors.black,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Dark",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              _appearanceValue = value;
                            });
                          },
                          groupValue: _appearanceValue,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Divider(height: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Notifications:"),
                        CupertinoSwitch(
                          value: _notifications,
                          onChanged: (value) {
                            setState(() {
                              _notifications = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: CupertinoListTile(
                leading: const Icon(CupertinoIcons.calendar),
                title: const Text("Calendario de Vuelos"),
                trailing: const Icon(CupertinoIcons.right_chevron),
                onTap: _navigateToCalendar,
              ),
            ),
          ),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: CupertinoListTile(
                title: const Center(
                  child: Text(
                    "Cerrar Sesión",
                    style: TextStyle(color: CupertinoColors.systemRed),
                  ),
                ),
                onTap: _logout,
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}