import 'package:flutter/material.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:provider/provider.dart';

Future<bool> showPasswordVerificationDialog(
    BuildContext context,
  ) {
    final loginProvider = context.read<LoginProvider>();
    var password = '';
    bool isPasswordVisible = false;

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Verifica tus datos'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: loginProvider.getUsername(),
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Ingresa tu usuario',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña';
                        }
                        if (value.length < 5) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: 'Ingresa tu contraseña',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    if (password == loginProvider.user.password) {
                      Navigator.pop(context, true);
                    } else {
                      Navigator.pop(context, false);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    ).then((value) => value ?? false);
  }