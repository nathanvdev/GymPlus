import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/panel.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/member_table_provider.dart';
import 'package:provider/provider.dart';

class SignInPage2 extends StatelessWidget {
  const SignInPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          Text('nathanvdev@gmail.com',
              style: TextStyle(
                  color: Theme.of(context).shadowColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ],
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(32.0),
          constraints: const BoxConstraints(maxWidth: 1800),
          child: const Row(
            children: [
              Expanded(child: _Logo()),
              Expanded(
                child: Center(child: _FormContent()),
              ),
            ],
          ),
        )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: Colors.black,
          border:
              Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: buildShadowBox()),
      child: Image.file(
        File('lib/assets/logo.jpg'),
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent();

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<LoginProvider>();
    final memberProvider = context.read<MemberTableProvider>();
    late String usuario = "";
    late String password = "";

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu usuario';
                }

                if (value.length < 5) {
                  return 'El usuario debe tener al menos 6 caracteres';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Usuario',
                hintText: 'Ingresa tu usuario',
                prefixIcon: Icon(Icons.person_outline_rounded),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                usuario = '';
                usuario = value;
              },
            ),
            _gap(),
            TextFormField(
              initialValue: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu contraseña';
                }

                if (value.length < 5) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  hintText: 'Ingresa tu contraseña',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
              onChanged: (value) {
                password = '';
                password = value;
              },
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Iniciar Sesion',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final response =
                        await LoginProvider().login(usuario, password);

                    if (response == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content:
                                const Text('Usuario o contraseña incorrectos'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Panel()),
                      );
                      loginProvider.setUser(response);
                      memberProvider.refresh();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
