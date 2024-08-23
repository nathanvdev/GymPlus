import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/providers/product_provider.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StorePage();
    
  }
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    final producProvider = context.watch<ProductProvider>();

    return Scaffold(
        body: Center(
            child: SafeArea(
                child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
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
        ),
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
                            child: const Text(
                              'Agregar Producto',
                              style: TextStyle(fontSize: 11),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Editar Producto',
                              style: TextStyle(fontSize: 11)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FilledButton(
                            onPressed: () {},
                            child: const Text('Eliminar Producto',
                                style: TextStyle(fontSize: 11))),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                            ),
                            child: SearchBar(
                              textStyle: const WidgetStatePropertyAll(
                                TextStyle(
                                  fontSize: 10,
                                  // font bold
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              hintText: "Buscar Producto",
                              shadowColor: WidgetStatePropertyAll(
                                Theme.of(context).shadowColor,
                              ),
                              elevation: const WidgetStatePropertyAll(8),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    color: Theme.of(context).shadowColor,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                producProvider.filtringProducts(value);
                              },
                            ),
                          ),
                        ),
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
                            for (int i = 0;
                                i < producProvider.filtredProductList.length;
                                i += 3)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int j = 0; j < 3; j++)
                                    if (i + j <
                                        producProvider
                                            .filtredProductList.length)
                                      itemcard(
                                        context,
                                        producProvider
                                            .filtredProductList[i + j].name,
                                        producProvider
                                            .filtredProductList[i + j].price,
                                        producProvider
                                            .filtredProductList[i + j].stock,
                                        producProvider
                                            .filtredProductList[i + j].imageurl,
                                      ),
                                ],
                              ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.94,
                width: MediaQuery.of(context).size.width * 0.25,
                padding: const EdgeInsets.all(5),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Carrito de Compras',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.52,
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).shadowColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).shadowColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Subtotal: Q 500.00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Descuento: Q 50.00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Total: Q 450.00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                        onPressed: () {}, child: const Text('Realizar Compra')),
                    const SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                        onPressed: () {}, child: const Text('Vaciar Carrito')),
                  ],
                )),
          ],
        )
      ],
    ))));
  }

  Container itemcard(BuildContext context, String name, String price,
      String stock, String imageurl) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.24,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageurl),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Q $price DSP:$stock',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
