import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/member_table_provider.dart';
import 'package:frontend/screens/sign_in.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemberTableProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => MemberSelectedProvider()),

      ], 
      child: MaterialApp(
        title: 'Gymplus App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightMode(),
        // theme: AppTheme().lightMode(),
        home: const SignInPage2(),
      ),
    );
  }
}
