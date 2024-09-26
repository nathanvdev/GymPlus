import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/member_table.provider.dart';

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
            Navigator.of(context).pop();
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
}
