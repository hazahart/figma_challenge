import 'package:figma_challenge/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:figma_challenge/screens/new_flight.dart';

void main() => runApp(const PlaneApp());

class PlaneApp extends StatelessWidget {
  const PlaneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      // debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      initialRoute: '/onboarding0',
      routes: {
        '/': (context) => const HomeScreen(),
        '/onboarding0': (context) => const NewFlight(),
      },
    );
  }
}
