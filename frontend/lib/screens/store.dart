import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/providers/product_provider.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const StorePage()
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartItemsProvider()),
      ],
      child: MaterialApp(
        title: 'Gymplus App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightMode(),
        home: const StorePage(),
      ),
    );
  }
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  Future<void> _future = Future.any([]);

  @override
  void initState() {
    super.initState();
    _future = context.read<ProductProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final producProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartItemsProvider>();
    final loginProvider = context.read<LoginProvider>();

    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: buildShadowBox(),
                          ),
                          child: const Menu(), // Removed const
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.76,
                        child: Row(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: buttonsView(context, loginProvider,
                                        producProvider, cartProvider),
                                  ),
                                  productsView(context, producProvider),
                                ],
                              ),
                            ),
                            cartView(context, cartProvider, producProvider),
                          ],
                        ),
                      )
                    ],
                  );
                })));
  }

  Row buttonsView(BuildContext context, LoginProvider loginProvider,
      ProductProvider producProvider, CartItemsProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FilledButton(
          child: const Row(
            children: [
              Text(
                'Agregar  ',
                style: TextStyle(fontSize: 15),
              ),
              Icon(
                Icons.add_circle,
                size: 17,
              ),
            ],
          ),
          onPressed: () {
            addProductDialog(
              context,
              loginProvider,
              producProvider,
            );
          },
        ),
        const SizedBox(
          width: 10,
        ),
        FilledButton(
          child: const Row(
            children: [
              Text('Editar  ', style: TextStyle(fontSize: 15)),
              Icon(
                Icons.edit,
                size: 17,
              ),
            ],
          ),
          onPressed: () {
            if (cartProvider.getProducts().isEmpty ||
                cartProvider.getProducts().length > 1) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content:
                        const Text('SOLO PUEDES EDITAR UN PRODUCTO A LA VEZ'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            } else {
              final nameProductController = TextEditingController();
              final priceProductController = TextEditingController();
              final stockProductController = TextEditingController();
              final imageProductController = TextEditingController();
              final GlobalKey<FormState> formKey = GlobalKey<FormState>();
              var product = producProvider
                  .getProductById(cartProvider.getProducts()[0].id.toString());
              nameProductController.text = product.name;
              priceProductController.text = product.price;
              stockProductController.text = product.stock;
              imageProductController.text = product.imageurl;
              imageProductController.text = product.imageurl.split('/').last;
              var id = int.parse(product.id);
              editProductDialog(
                  context,
                  formKey,
                  id,
                  nameProductController,
                  priceProductController,
                  stockProductController,
                  imageProductController,
                  loginProvider,
                  producProvider);
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        FilledButton(
          child: const Row(
            children: [
              Text('Eliminar  ', style: TextStyle(fontSize: 15)),
              Icon(
                Icons.delete,
                size: 17,
              ),
            ],
          ),
          onPressed: () {
            if (cartProvider.getProducts().isEmpty ||
                cartProvider.getProducts().length > 1) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content:
                        const Text('SOLO PUEDES ELIMINAR UN PRODUCTO A LA VEZ'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  );
                },
              );
            } else {
              var id = cartProvider.getProducts()[0].id;
              cartProvider.clear();
              deleteProductDialog(
                context,
                id,
                loginProvider,
                producProvider,
              );
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.13,
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
                  fontSize: 15,
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
                setState(() {
                  producProvider.filtringProducts(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Container cartView(
    BuildContext context,
    CartItemsProvider cartProvider,
    ProductProvider producProvider,
  ) {
    return Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 0.25,
        margin: const EdgeInsets.only(
          top: 20,
          bottom: 20,
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
              height: MediaQuery.of(context).size.height * 0.61,
              width: MediaQuery.of(context).size.width * 0.25,
              margin: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 15,
                  border: TableBorder.symmetric(
                    inside: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  headingRowHeight: 25,
                  showCheckboxColumn: false,
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Producto',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Precio',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Cantidad',
                      ),
                    ),
                  ],
                  rows: [
                    for (int i = 0; i < cartProvider.getProducts().length; i++)
                      DataRow(cells: [
                        DataCell(
                          Text(
                            producProvider
                                .getProductById(
                                    cartProvider.getProducts()[i].id.toString())
                                .name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            cartProvider.cartItems[i].subtotal
                                .toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (cartProvider.getProducts()[i].quantity >
                                      1) {
                                    cartProvider.getProducts()[i].quantity--;
                                    double price = double.parse(producProvider
                                        .getProductById(cartProvider
                                            .getProducts()[i]
                                            .id
                                            .toString())
                                        .price);
                                    cartProvider.cartItems[i]
                                        .setSubtotal(price);
                                  } else {
                                    cartProvider.removeProduct(
                                        cartProvider.getProducts()[i].id);
                                  }
                                });
                              },
                              child: const Icon(Icons.remove_circle),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              cartProvider.getProducts()[i].quantity.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  cartProvider.getProducts()[i].quantity++;
                                  double price = double.parse(producProvider
                                      .getProductById(cartProvider
                                          .getProducts()[i]
                                          .id
                                          .toString())
                                      .price);
                                  cartProvider.cartItems[i].setSubtotal(price);
                                });
                              },
                              child: const Icon(Icons.add_circle),
                            ),
                          ],
                        )),
                      ]),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              width: MediaQuery.of(context).size.width * 0.15,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).shadowColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Total: Q ${getSubtotalCart().toStringAsFixed(2)}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FilledButton(
              child: const Text('Realizar Compra'),
              onPressed: () async {
                if (cartProvider.getProducts().isEmpty) {
                  displayMessageDialog(
                      context, 'No hay productos en el carrito');
                } else {
                  var auth = await showPasswordDialog(
                    context,
                  );
                  if (auth) {
                    try {
                      if (context.mounted) {
                        final loginProvider = context.read<LoginProvider>();
                        final dio = Dio();
                        final response = await dio.post(
                          'http://localhost:3569/sale/add',
                          data: {
                            'total': getSubtotalCart(),
                            'admin_id': loginProvider.user.memberId,
                            'items': cartProvider.cartItems
                                .map((item) => {
                                      'product_name': producProvider
                                          .getProductById(item.id.toString())
                                          .name,
                                      'price': double.parse(producProvider
                                          .getProductById(item.id.toString())
                                          .price),
                                      'quantity': item.quantity,
                                    })
                                .toList(),
                          },
                        );

                        if (response.statusCode == 200) {
                          cartProvider.clear();
                          if (context.mounted) {
                            displayMessageDialog(
                                context, 'Compra realizada correctamente');
                          }
                        } else {
                          if (context.mounted) {
                            displayMessageDialog(context,
                                'Error al realizar la compra: ${response.data['msg']}');
                          }
                        }
                      }
                    } catch (e) {
                      if (context.mounted) {
                        displayMessageDialog(
                            context, 'Hubo un error al realizar la compra $e');
                      }
                    }
                  }else{
                    if (context.mounted) {
                      displayMessageDialog(context, 'Contraseña Incorrecta');
                    }
                  }
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
                onPressed: () {
                  setState(() {
                    context.read<CartItemsProvider>().clear();
                  });
                },
                child: const Text('Vaciar Carrito')),
          ],
        ));
  }

  Container productsView(BuildContext context, ProductProvider producProvider) {
    return Container(
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
                      if (i + j < producProvider.filtredProductList.length)
                        itemcard(
                          context,
                          producProvider.filtredProductList[i + j].id,
                          producProvider.filtredProductList[i + j].name,
                          producProvider.filtredProductList[i + j].price,
                          producProvider.filtredProductList[i + j].stock,
                          producProvider.filtredProductList[i + j].imageurl,
                        ),
                  ],
                ),
            ],
          )),
    );
  }

  Future<dynamic> addProductDialog(BuildContext context,
      LoginProvider loginProvider, ProductProvider producProvider) {
    final nameProductController = TextEditingController();
    final priceProductController = TextEditingController();
    final stockProductController = TextEditingController();
    final imageProductController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final dio = Dio();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Agregar Producto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      } else if (!RegExp(r'[a-zA-Z0-9]+[ .,%$#@]?')
                          .hasMatch(value)) {
                        return 'El nombre solo debe contener letras y números';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: priceProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un precio';
                      } else if (!RegExp(r'^[0-9]+(\.[0-9]{1,2})?$')
                          .hasMatch(value)) {
                        return 'El precio debe ser un número';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      hintText: 'Precio del Producto Q 0.00',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: stockProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la cantidad disponible';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'La cantidad disponible debe ser un número';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      hintText: 'Cantidad Disponible',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        String? filePath = result.files.single.path;
                        if (filePath != null) {
                          File file = File(filePath);
                          String newPath =
                              'lib/assets/tmp/${result.files.single.name}';
                          await file.copy(newPath);
                          imageProductController.text =
                              result.files.single.name;
                        }
                      }
                    },
                    child: const Text('Seleccionar Imagen'),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    enabled: false,
                    controller: imageProductController,
                    decoration: const InputDecoration(
                      labelText: 'Imagen',
                      hintText: 'Ruta de la Imagen',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () async {
                if (formKey.currentState!.validate() == false) {
                  return;
                }
                var auth = await showPasswordDialog(
                  context,
                );

                if (auth == false) {
                  displayMessageDialog(context.mounted ? context : context,
                      'Contraseña Incorrecta');
                } else {
                  try {
                    final response = await dio.put(
                      'http://localhost:3569/product/add',
                      data: {
                        'name': nameProductController.text,
                        'price': priceProductController.text,
                        'stock': stockProductController.text,
                        'imageurl':
                            'lib/assets/tmp/${imageProductController.text}',
                      },
                    );
                    if (response.statusCode == 200) {
                      producProvider.refresh();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      if (context.mounted) {
                        displayMessageDialog(
                            context, 'Producto agregado correctamente');
                      }
                    } else {
                      if (context.mounted) {
                        displayMessageDialog(context,
                            'Error al agregar el producto: ${response.data['msg']}');
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      displayMessageDialog(
                          context, 'Hubo un error al agregar el producto');
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> editProductDialog(
      BuildContext context,
      GlobalKey<FormState> formKey,
      int id,
      TextEditingController nameProductController,
      TextEditingController priceProductController,
      TextEditingController stockProductController,
      TextEditingController imageProductController,
      LoginProvider loginProvider,
      ProductProvider producProvider) {
    final dio = Dio();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Editar Producto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.3,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      } else if (!RegExp(r'[a-zA-Z0-9]+[ .,%$#@]?')
                          .hasMatch(value)) {
                        return 'El nombre solo debe contener letras y números';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre del Producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: priceProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un precio';
                      } else if (!RegExp(r'^[0-9]+(\.[0-9]{1,2})?$')
                          .hasMatch(value)) {
                        return 'El precio debe ser un número';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      hintText: 'Precio del Producto Q 0.00',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: stockProductController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la cantidad disponible';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'La cantidad disponible debe ser un número';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      hintText: 'Cantidad Disponible',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        String? filePath = result.files.single.path;
                        if (filePath != null) {
                          File file = File(filePath);
                          String newPath =
                              'lib/assets/tmp/${result.files.single.name}';
                          await file.copy(newPath);
                          imageProductController.text =
                              result.files.single.name;
                        }
                      }
                    },
                    child: const Text('Seleccionar Imagen'),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: imageProductController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Imagen',
                      hintText: 'Ruta de la Imagen',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Agregar'),
              onPressed: () async {
                if (formKey.currentState!.validate() == false) {
                  return;
                }
                var auth = await showPasswordDialog(
                  context,
                );

                if (auth == false) {
                  displayMessageDialog(context.mounted ? context : context,
                      'Contraseña Incorrecta');
                } else {
                  try {
                    final response = await dio.put(
                      'http://localhost:3569/product/edit/$id',
                      data: {
                        'name': nameProductController.text,
                        'price': priceProductController.text,
                        'stock': stockProductController.text,
                        'imageurl':
                            'lib/assets/tmp/${imageProductController.text}',
                      },
                    );
                    if (response.statusCode == 200) {
                      producProvider.refresh();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      if (context.mounted) {
                        displayMessageDialog(
                            context, 'Producto editado correctamente');
                      }
                    } else {
                      if (context.mounted) {
                        displayMessageDialog(context,
                            'Error al editar el producto: ${response.data['msg']}');
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      displayMessageDialog(
                          context, 'Hubo un error al editar el producto $e');
                    }
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProductDialog(
    BuildContext context,
    int id,
    LoginProvider loginProvider,
    ProductProvider productProvider,
  ) async {
    bool isVerified = await showPasswordDialog(
      context,
    );

    if (isVerified) {
      // Proceder con la lógica de eliminación del producto
      try {
        var productimg = productProvider.getProductById(id.toString()).imageurl;
        final dio = Dio();
        final response = await dio.delete(
          'http://localhost:3569/product/delete/$id',
        );
        if (response.statusCode == 200) {
          final file = File(productimg);
          if (await file.exists()) {
            await file.delete();
          }

          productProvider.deleteProduct(id.toString());
          productProvider.refresh();
          if (context.mounted) {
            displayMessageDialog(context, 'Producto eliminado correctamente');
          }
        } else {
          if (context.mounted) {
            displayMessageDialog(context,
                'Error al eliminar el producto: ${response.data['msg']}');
          }
        }
      } catch (e) {
        if (context.mounted) {
          displayMessageDialog(
              context, 'Hubo un error al eliminar el producto');
        }
      }
    } else {
      if (context.mounted) {
        displayMessageDialog(context,
            'La contraseña ingresada no coincide con la de tu usuario');
      }
    }
  }

  Future<bool> showPasswordDialog(
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

  void displayMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  InkWell itemcard(BuildContext context, String id, String name, String price,
      String stock, String imageurl) {
    final cartProvider = context.read<CartItemsProvider>();

    return InkWell(
      onTap: () {
        setState(() {
          if (cartProvider
              .getProducts()
              .any((item) => item.id == int.parse(id))) {
            cartProvider.removeProduct(int.parse(id));
          } else {
            ProductProvider productProvider = context.read<ProductProvider>();
            var product = productProvider.getProductById(id);
            cartProvider.addProduct(int.parse(id), double.parse(product.price));
          }
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.24,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow:
              cartProvider.getProducts().any((item) => item.id == int.parse(id))
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : [],
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
      ),
    );
  }

  getSubtotalCart() {
    double total = 0;
    for (var item in context.read<CartItemsProvider>().cartItems) {
      total += item.subtotal;
    }
    return total;
  }
}

class ItemCart {
  String productName;
  double price;
  int quantity;

  ItemCart(this.productName, this.price, this.quantity);
}
