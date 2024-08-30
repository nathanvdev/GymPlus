import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/membership_payment.dart';
import 'package:frontend/screens/providers/login.provider.dart';
import 'package:frontend/screens/providers/member_table.provider.dart';
import 'package:provider/provider.dart';

class PaymentProcessWidget extends StatefulWidget {
  const PaymentProcessWidget({super.key});

  @override
  State<PaymentProcessWidget> createState() => _PaymentProcessState();
}

class _PaymentProcessState extends State<PaymentProcessWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 1-> standard
  int? membershipType = 1;
  double billingQuantity = 0;
  double billingRate = 1;
  final TextEditingController _initialDate = TextEditingController();
  final TextEditingController _finalDate = TextEditingController();
  final TextEditingController _subTotal = TextEditingController();
  double discount = 0.0;
  String discountsDescription = "";
  final TextEditingController _total = TextEditingController();
  //variable para el monto recibido
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _change = TextEditingController();
  // 1-> efectivo, 2-> tarjeta, 3-> transferencia
  int? paymentMethod = 1;
  // 1-> pagado, 2-> pendiente
  int? paymentStatus = 1;
  String paymentReference = "";

  @override
  Widget build(BuildContext context) {
    final memberselectedProvider = context.read<MemberSelectedProvider>();
    final memberProvider = context.read<MemberTableProvider>();
    final loginProvider = context.read<LoginProvider>();

    //

    _initialDate.text = DateTime.now().toString().substring(0, 10);
    return AlertDialog(
      title: const Text('Realizar Pago'),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).canvasColor,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: memberProvider.getMemberNameById(
                            memberselectedProvider.getSelectedMemberId()),
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          hintText: "Nombre del miembro",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                          initialSelection: membershipType,
                          expandedInsets: const EdgeInsets.all(10),
                          label: const Text('Tipo de Membresia'),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: 1, label: 'Standard')
                          ],
                          onSelected: (value) => setState(() {
                            membershipType = value;
                          }),
                        ),
                      )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Theme.of(context).shadowColor),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 0),
                          child: Text(
                            "Cantidad",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: billingQuantity,
                            min: 0,
                            max: 30,
                            allowedInteraction: SliderInteraction.tapAndSlide,
                            divisions: 30,
                            label: billingQuantity.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                if (membershipType == 0) {
                                  _showDialog('Error',
                                      'Por favor seleccione un tipo de membresia');
                                  return;
                                } else {
                                  billingQuantity = value;
                                  calculeteSubTotal();
                                  calculateTotal();
                                  setState(() {
                                    _finalDate.text = DateTime.now()
                                        .add(Duration(days: getTotalDays()))
                                        .toString()
                                        .substring(0, 10);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Theme.of(context).shadowColor),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 0),
                          child: Text(
                            "Ciclo",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: billingRate,
                            min: 1,
                            max: 4,
                            allowedInteraction: SliderInteraction.tapAndSlide,
                            divisions: 3,
                            label: billingRateToString(billingRate.toInt()),
                            onChanged: (double value) {
                              setState(() {
                                if (membershipType == 0) {
                                  _showDialog('Error',
                                      'Por favor seleccione un tipo de membresia');
                                  return;
                                } else {
                                  billingRate = value;
                                  calculeteSubTotal();
                                  calculateTotal();
                                  setState(() {
                                    _finalDate.text = DateTime.now()
                                        .add(Duration(days: getTotalDays()))
                                        .toString()
                                        .substring(0, 10);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una fecha';
                        }
                        return null;
                      },
                      controller: _initialDate,
                      decoration: const InputDecoration(
                        labelText: "Fecha inicial",
                        hintText: "Fecha Inicial",
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: getInitialDate(),
                          firstDate: DateTime(1900),
                          lastDate:
                              DateTime.now().add(const Duration(days: 90)),
                        );
                        if (pickeddate != null) {
                          setState(() {
                            _initialDate.text =
                                pickeddate.toString().substring(0, 10);
                            _finalDate.text = pickeddate
                                .add(Duration(days: getTotalDays()))
                                .toString()
                                .substring(0, 10);
                          });
                        }
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una fecha';
                        }
                        return null;
                      },
                      controller: _finalDate,
                      decoration: const InputDecoration(
                        labelText: "Fecha Final",
                        hintText: "FechaFinal",
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          //
                          initialDate: getFinalDate(),
                          firstDate: DateTime(1900),
                          lastDate:
                              DateTime.now().add(const Duration(days: 930)),
                        );
                        if (pickeddate != null) {
                          setState(() {
                            _finalDate.text =
                                pickeddate.toString().substring(0, 10);
                          });
                        }
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: _subTotal,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una cantidad';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Subtotal",
                        hintText: "Subtotal a pagar",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Descuento",
                          hintText: "Descuento a aplicar",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Retorna temprano si el valor está vacío
                          if (value.isEmpty) {
                            discount = 0;
                            calculateTotal();
                            return;
                          }

                          setState(() {
                            double? numericValue = double.tryParse(value);
                            if (numericValue == null) {
                              // Muestra un diálogo si el valor no es un número
                              _showDialog('Error',
                                  'Por favor ingrese un valor numérico');
                            } else if (numericValue < 0) {
                              // Muestra un diálogo si el valor es negativo
                              _showDialog('Error',
                                  'Por favor ingrese un valor positivo');
                            } else {
                              double subtotal =
                                  double.tryParse(_subTotal.text) ?? 0;
                              if (numericValue > subtotal) {
                                // Muestra un diálogo si el descuento es mayor que el subtotal
                                _showDialog('Error',
                                    'El descuento no puede ser mayor al subtotal');
                              } else {
                                // Si todo está correcto, asigna el valor a discount y calcula el total
                                discount = numericValue;
                                calculateTotal();
                              }
                            }
                          });
                        }),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Descripcion",
                        hintText: "Descripcion del descuento",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          discountsDescription = value;
                        });
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una cantidad';
                        }
                        return null;
                      },
                      enabled: false,
                      controller: _total,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+.\d?$')),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Total",
                        hintText: "Total a pagar",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Monto Recibido",
                        hintText: "Monto recibido del cliente",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Retorna temprano si el valor está vacío
                        if (value.isEmpty) {
                          _change.text = '';
                          return;
                        }

                        setState(() {
                          double? numericValue = double.tryParse(value);
                          if (numericValue == null) {
                            // Muestra un diálogo si el valor no es un número
                            _showDialog(
                                'Error', 'Por favor ingrese un valor numérico');
                          } else if (numericValue < 0) {
                            // Muestra un diálogo si el valor es negativo
                            _showDialog(
                                'Error', 'Por favor ingrese un valor positivo');
                          } else {
                            // Si todo está correcto, asigna el valor a discount y calcula el total
                            _cashController.text = numericValue.toString();
                            calculateChange();
                          }
                        });
                      },
                      onEditingComplete: () {
                        // Asegúrate de convertir los valores de texto a números antes de compararlos
                        if (double.tryParse(_change.text) != null &&
                            double.tryParse(_total.text) != null) {
                          double changeValue = double.parse(_change.text);
                          double totalValue = double.parse(_total.text);

                          if (changeValue < totalValue) {
                            _showDialog('Error',
                                'El monto recibido no puede ser menor al total');
                          }
                        } else {
                          _showDialog('Error',
                              'Por favor ingrese valores numéricos válidos');
                        }
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: _change,
                      decoration: const InputDecoration(
                        labelText: "Cambio",
                        hintText: "Cambio a entregar al cliente",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                  SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                          initialSelection: paymentMethod,
                          expandedInsets: const EdgeInsets.all(10),
                          label: const Text('Metodo de Pago'),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: 1, label: 'Efectivo')
                          ],
                          onSelected: (value) => setState(() {
                            paymentMethod = value;
                          }),
                        ),
                      )),
                  SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                          initialSelection: paymentStatus,
                          expandedInsets: const EdgeInsets.all(10),
                          label: const Text('Estado del Pago'),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: 1, label: 'Cancelado'),
                            DropdownMenuEntry(value: 1, label: 'Pendiente')
                          ],
                          onSelected: (value) => setState(() {
                            paymentStatus = value;
                          }),
                        ),
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
                      ],
                      decoration: const InputDecoration(
                        labelText: "No. de referencia",
                        hintText: "Referencia del Pago",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          paymentReference = value;
                        });
                      },
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: loginProvider.getUsername(),
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Autorizado Por",
                        hintText: "Empleado que autoriza el pago",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate() == false) {
              return;
            }

            try {
              final payment = MembershipPayment(
                memberId:
                    memberselectedProvider.getSelectedMemberId(),
                membershipPlan: int.parse(membershipType.toString()),
                billingQuantity: int.parse(billingQuantity.toString()),
                billingCycle: int.parse(billingRate.toString()),
                initialPaymentDate: _initialDate.text,
                nextPaymentDate: _finalDate.text,
                subtotal: double.parse(_subTotal.text),
                discounts: double.parse(discount.toString()),
                discountsDescription: discountsDescription,
                total: double.parse(_total.text),
                paymentMethod: int.parse(paymentMethod.toString()),
                cash: double.parse(_cashController.text),
                change: double.parse(_change.text),
                paymentStatus: int.parse(paymentStatus.toString()),
                paymentReference: paymentReference,
                adminMemberId: loginProvider.user.id,
              );
              var password = '';
              bool isPasswordVisible = false;
              final dio = Dio();

              authDialog(context, loginProvider, isPasswordVisible, password,
                  dio, payment, memberProvider);
            } catch (e) {
              _showDialog('Error', 'Ocurrió un error al procesar el pago: $e');
            }
          },
          child: const Text('Aceptar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }

  Future<dynamic> authDialog(
      BuildContext context,
      LoginProvider loginProvider,
      bool isPasswordVisible,
      String password,
      Dio dio,
      MembershipPayment payment,
      MemberTableProvider memberProvider) {
    return showDialog(
      context: context,
      builder: (context) {
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
                      )),
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
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () async {
                if (password == loginProvider.user.password) {
                  try {
                    await dio.post(
                      'http://localhost:3569/payment/add',
                      data: payment.toJson(),
                    );

                    memberProvider.refresh();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                    showDialog(
                      context: context.mounted ? context : context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content:
                              const Text('Hubo un error al guardar el miembro'),
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
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Contraseña Incorrecta'),
                        content: const Text(
                            'La contraseña ingresada no coincide con la de tu usuario'),
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
              },
            ),
          ],
        );
      },
    );
  }

  DateTime getFinalDate() {
    if (_finalDate.text.isEmpty) {
      return DateTime.now();
    } else {
      return DateTime.parse(_finalDate.text);
    }
  }

  DateTime getInitialDate() {
    if (_initialDate.text.isEmpty) {
      return DateTime.now();
    } else {
      return DateTime.parse(_initialDate.text);
    }
  }

  String billingRateToString(int rate) {
    switch (rate) {
      case 1:
        return "Dia";
      case 2:
        return "Semana";
      case 3:
        return "Mes";
      case 4:
        return "Año";
      default:
        return "Dia";
    }
  }

  int getTotalDays() {
    if (billingRate == 1) {
      return 1 * billingQuantity.toInt();
    } else if (billingRate == 2) {
      return 7 * billingQuantity.toInt();
    } else if (billingRate == 3) {
      return 30 * billingQuantity.toInt();
    } else if (billingRate == 4) {
      return 365 * billingQuantity.toInt();
    } else {
      return 0;
    }
  }

  calculeteSubTotal() {
    int day = 5;
    int week = 10;
    int month = 100;
    int year = 1000;

    if (billingRate == 1) {
      setState(() {
        _subTotal.text = (day * billingQuantity).toString();
      });
    } else if (billingRate == 2) {
      setState(() {
        _subTotal.text = (week * billingQuantity).toString();
      });
    } else if (billingRate == 3) {
      setState(() {
        _subTotal.text = (month * billingQuantity).toString();
      });
    } else if (billingRate == 4) {
      setState(() {
        _subTotal.text = (year * billingQuantity).toString();
      });
    }
  }

  calculateTotal() {
    double subTotal = double.parse(_subTotal.text);
    setState(() {
      _total.text = (subTotal - discount).toString();
    });
  }

  calculateChange() {
    double total = double.parse(_total.text);
    double cash = double.parse(_cashController.text);
    setState(() {
      _change.text = (cash - total).toString();
    });
  }

  void _showDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        });
  }
}
