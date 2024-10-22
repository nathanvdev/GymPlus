import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../providers/member_table.provider.dart';

class BodyMeasurements extends StatefulWidget {
  const BodyMeasurements({super.key});

  @override
  State<BodyMeasurements> createState() => _BodyMeasurementsState();
}

class _BodyMeasurementsState extends State<BodyMeasurements> {
  final fullNameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final imcController = TextEditingController();
  final armController = TextEditingController();
  final chestController = TextEditingController();
  final abdomenController = TextEditingController();
  final gluteusController = TextEditingController();
  final thighController = TextEditingController();
  final calfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      fullNameController.text = context
          .read<MemberTableProvider>()
          .getMemberNameById(
              context.read<MemberSelectedProvider>().getSelectedMemberId());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Medidas Corporales',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 400,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: fullNameController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Miembro',
                      hintText: "Nombre del miembro",
                      border: OutlineInputBorder(),
                    ),
                  )),
            ),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Ingrese las mediciones antropométricas en los campos correspondientes.',
                    style: TextStyle(
                      fontSize: 15,
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.31,
                  width: MediaQuery.of(context).size.width * 0.23,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/IMC-clasificacion.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Altura: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setIMC();
                              },
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Peso: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setIMC();
                              },
                              decoration: const InputDecoration(
                                hintText: '0.00 lb',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Brazo: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: armController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Abdomen: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: abdomenController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Gluteo: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: gluteusController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'IMC: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: imcController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Pecho: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: chestController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Muslo: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: thighController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Pantorrila: ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 60,
                            height: 35,
                            child: TextFormField(
                              controller: calfController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '0.00 cm',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            showPasswordDialog(context).then((value) async {
              if (value) {
                final data = {
                  'member_id': context
                      .read<MemberSelectedProvider>()
                      .getSelectedMemberId(),
                  'height': heightController.text,
                  'weight': weightController.text,
                  'imc': imcController.text,
                  'arm': armController.text,
                  'chest': chestController.text,
                  'abdomen': abdomenController.text,
                  'gluteus': gluteusController.text,
                  'thigh': thighController.text,
                  'calf': calfController.text,
                };

                final dio = Dio();
                try {
                  final response = await dio.post(
                    'http://localhost:3569/measurement/add',
                    data: data,
                  );
                  if (response.statusCode == 200) {
                    if (context.mounted) {
                      Navigator.pop(context);
                      displayMessageDialog(
                          context, 'Medidas guardadas correctamente');
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.pop(context);
                      displayMessageDialog(
                          context, 'Error en el servidor al guardar las medidas');
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                      Navigator.pop(context);
                    displayMessageDialog(
                        context, 'Error al conectar con el server');
                  }
                }

              } else {
    Navigator.pop(context);
                displayMessageDialog(context, 'Contraseña incorrecta');
              }
            });
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  setIMC() {
    if (heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
      final height = double.parse(heightController.text);
      var weight = double.parse(weightController.text);
      weight = weight / 2.205;
      final imc = weight / (height * height);
      imcController.text = imc.toStringAsFixed(2);
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
}
