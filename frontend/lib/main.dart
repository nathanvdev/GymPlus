import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/providers/expense_provider.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/providers/member_table.provider.dart';
import 'package:frontend/providers/payments_provider.dart';
import 'package:frontend/providers/product_provider.dart';
import 'package:frontend/providers/profileview_provider.dart';
import 'package:frontend/providers/sales_provider.dart';
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
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartItemsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentsProvider()),
        ChangeNotifierProvider(create: (_) => SalesProvider()),
        ChangeNotifierProvider(create: (_) => MemberTableProvider()),
        ChangeNotifierProvider(create: (_) => MemberSelectedProvider()),
        ChangeNotifierProvider(create: (_) => ProfileviewProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ],
      child: MaterialApp(
        title: 'Gymplus App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightMode(),
        home: const LoginScreen(),
      ),
    );
  }
}
