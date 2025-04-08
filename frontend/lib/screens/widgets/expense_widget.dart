import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/expense.dart';
import 'package:frontend/providers/expense_provider.dart';
import 'package:frontend/providers/login_provider.dart';
import 'package:frontend/utils/auth.dart';
import 'package:frontend/utils/show_dialog.dart';
import 'package:provider/provider.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({super.key, required this.type, this.expenseID = -1});

  final int expenseID;
  // 1: Nuevo gasto, 2: Editar gasto
  final int type;

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  int expeseID = -1;

  final _date = TextEditingController();
  final _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _future = Future.any([]);
  final _name = TextEditingController();
  final _seller = TextEditingController();
  final _total = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  getData() async {
    if (widget.type == 1) {
      _date.text = DateTime.now().toString().substring(0, 10);
      return Future.value();
    } else {
      var response =
          await context.read<ExpenseProvider>().getExpense(widget.expenseID);
      response = jsonDecode(response);
      if (response["statusCode"] == 200) {
        _name.text = response['name'];
        _description.text = response['description'];
        _total.text = response['amount'].toString();
        _seller.text = response['supplier'];
        _date.text = response['date'];
      } else {
        if (context.mounted) {
          showDialogMessage(context, 'Error', response['msg']);
        }
      }
      return Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ExpenseProvider expenseProvider = context.read<ExpenseProvider>();

    return FutureBuilder(
        future: _future,
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return AlertDialog(
              title: widget.type == 1
                  ? const Text('Nuevo Gasto')
                  : const Text('Editar Gasto'),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).canvasColor,
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(30))),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, bottom: 10, left: 20, right: 20),
                          child: TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                              labelText: 'Nombre del producto',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          child: TextFormField(
                            controller: _description,
                            decoration: const InputDecoration(
                              labelText: 'Descripcion',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            enabled: widget.type == 1 ? true : false,
                            controller: _total,
                            decoration: const InputDecoration(
                              labelText: 'Total',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese un total';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                double? numericValue = double.tryParse(value);
                                if (numericValue == null) {
                                  // Muestra un diálogo si el valor no es un número
                                  showDialogMessage(context, 'Error',
                                      'Por favor ingrese un valor numérico');
                                  _total.text = '';
                                } else if (numericValue < 0) {
                                  // Muestra un diálogo si el valor es negativo
                                  showDialogMessage(context, 'Error',
                                      'Por favor ingrese un valor positivo');
                                  _total.text = '';
                                }
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _seller,
                            decoration: const InputDecoration(
                              labelText: 'Vendedor',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 20, right: 20),
                          child: TextFormField(
                            controller: _date,
                            decoration: const InputDecoration(
                              labelText: 'Fecha',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese una fecha';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate:
                                    DateTime.now().add(const Duration(days: 0)),
                              );
                              if (pickeddate != null) {
                                setState(() {
                                  _date.text =
                                      pickeddate.toString().substring(0, 10);
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                if (widget.type == 3)
                  TextButton(
                    onPressed: () {},
                    child: const Text("Confirmar"),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() == false) {
                      return;
                    }

                    final auth = await showPasswordVerificationDialog(context);
                    if (auth == false) {
                      showDialogMessage(context, 'Error', 'Contraseña incorrecta');
                      return;
                    }

                    final LoginProvider loginProvider =
                        context.read<LoginProvider>();
                    final tmpExpense = Expense(
                      name: _name.text,
                      description: _description.text,
                      amount: double.parse(_total.text),
                      supplier: _seller.text,
                      status: 1,
                      date: _date.text,
                      adminID: loginProvider.user.memberId,
                    );
                    if (widget.type == 1) {
                      var response =
                          await expenseProvider.addExpense(tmpExpense);

                      response = jsonDecode(response);

                      if (response['statusCode'] != 200) {
                        showDialogMessage(context, 'Error', response['msg']);
                      } else if (response['statusCode'] == 200) {
                        if (context.mounted) {
                          expenseProvider.refresh();
                          Navigator.of(context).pop();
                          showDialogMessage(
                              context, 'Exito', 'Gasto agregado correctamente');
                        }
                      }
                    } else if (widget.type == 2) {
                      tmpExpense.id = widget.expenseID;
                      var response =
                          await expenseProvider.updateExpense(tmpExpense);

                      response = jsonDecode(response);

                      if (response['statusCode'] != 200) {
                        showDialogMessage(context, 'Error', response['msg']);
                      } else if (response['statusCode'] == 200) {
                        if (context.mounted) {
                          expenseProvider.refresh();
                          Navigator.of(context).pop();
                          showDialogMessage(context, 'Exito',
                              'Gasto actualizado correctamente');
                        }
                      }
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          }
        });
  }
}
