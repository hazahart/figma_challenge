import 'package:figma_challenge/screens/home.dart';
import 'package:figma_challenge/screens/login_screen.dart';
import 'package:figma_challenge/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:figma_challenge/screens/new_flight.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_MX');
  runApp(const PlaneApp());
}

class PlaneApp extends StatelessWidget {
  const PlaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        // '/onboarding0': (context) => NewFlight(),
        '/signup': (context) => SignUpScreen(),
        // '/home': (context) => HomeScreen(),
      },
    );
  }
}
