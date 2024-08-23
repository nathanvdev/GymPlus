import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/widgets/display_menu.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StorePage();
  }
}

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SafeArea(
                child: Row(
      children: [
        Expanded(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: buildShadowBox(),
            ),
            child: const Menu(), // Removed const
          ),
        )),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FilledButton(
                            onPressed: () {},
                            child: const Text('Agregar Producto')),
                        FilledButton(
                            onPressed: () {},
                            child: const Text('Eliminar Producto')),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.85,
                    width: MediaQuery.of(context).size.width * 0.55,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 5,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemcard(context),
                              itemcard(context),
                              itemcard(context),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemcard(context),
                              itemcard(context),
                              itemcard(context),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemcard(context),
                              itemcard(context),
                              itemcard(context),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemcard(context),
                              itemcard(context),
                              itemcard(context),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              itemcard(context),
                              itemcard(context),
                              itemcard(context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.94,
                width: MediaQuery.of(context).size.width * 0.25,
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 5,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Carrito de Compras',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.49,
                        width: MediaQuery.of(context).size.width * 0.25,
                        margin: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                          left: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.25,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                            width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Subtotal: Q 500.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),),
                            Text("Descuento: Q 50.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),),
                            Text("Total: Q 450.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),),
                          ],
                        ),
                      ),
                      FilledButton(onPressed: () {}, child:  const Text('Realizar Compra')),
                      const SizedBox(height: 10,),
                      FilledButton(onPressed: (){}, child: const Text('Vaciar Carrito')),
                  ],
                )),
          ],
        )
      ],
    ))));
  }

  Container itemcard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.24,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Expanded(
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/tmp/iso100.webp'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Text(
              'Dymatize® ISO100® Hydrolyzed 5 Lbs.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Q 500.00  DSP: 10',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
