import 'package:flutter/cupertino.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(), child: Center(child: Text("Registro")));
  }
}
