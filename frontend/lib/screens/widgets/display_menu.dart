import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
  Widget build(BuildContext context) {
    return const Options();
  }
}

class Options extends StatelessWidget {
  const Options({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  final loginProvider = context.read<LoginProvider>();

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0), width: 2),
              borderRadius: BorderRadius.circular(30),
              boxShadow: buildShadowBox()),
          child: Image.file(
            File('lib/assets/logo.jpg'),
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "Bienvenido ${loginProvider.getUsername()} || ${loginProvider.getRol()}",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        MenuButtonBar(
          title: "Home",
          icon: Icons.home,
          onPressed: () {},
        ),
        MenuButtonBar(
          title: "Miembros",
          icon: Icons.people,
          onPressed: () {},
        ),
        MenuButtonBar(
          title: "Tienda",
          icon: Icons.store,
          onPressed: () {},
        ),
        MenuButtonBar(
          title: "Configuracion",
          icon: Icons.settings,
          onPressed: () {},
        ),
        MenuButtonBar(
          title: "Cerrar Sesion",
          icon: Icons.logout,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class MenuButtonBar extends StatelessWidget {
  const MenuButtonBar({
    required this.title,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
                onPressed: onPressed,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title),
                      ],
                    ),
                    const SizedBox(width: 15),
                  ],
                )),
          )),
    );
  }
}
