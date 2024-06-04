import 'package:flutter/material.dart';

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
    return ListView(
      children: const <Widget>[
        MenuButtonBar(title: "Home", icon: Icons.home),
        SizedBox(height: 20),
        MenuButtonBar(title: "Miembros", icon: Icons.people),
        SizedBox(height: 20),
        MenuButtonBar(title: "Tienda", icon: Icons.store),
        SizedBox(height: 20),
        MenuButtonBar(title: "Configuracion", icon: Icons.settings),
        SizedBox(height: 20),
        MenuButtonBar(title: "Cerrar Sesion", icon: Icons.logout),
        SizedBox(height: 20),
      ],
    );
  }
}

class MenuButtonBar extends StatelessWidget {
  const MenuButtonBar({
    required this.title,
    required this.icon,
    super.key,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
              onPressed: () {},
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
        ));
  }
}
