

import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymplus App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightMode(),
      // theme: AppTheme().lightMode(),
      home: const SignInPage2(),
    );
  }
}


