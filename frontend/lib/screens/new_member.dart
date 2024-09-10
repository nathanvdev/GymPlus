import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/member_table.provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'widgets/member_form_widget.dart';

class NewMemberScreen extends StatefulWidget {
  const NewMemberScreen({super.key});
  @override
  State<NewMemberScreen> createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  final imageProductController = TextEditingController();
  final _name = TextEditingController();
  final _lastname = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _emergencyContactName = TextEditingController();
  final _emergencyContactPhone = TextEditingController();
  final _birthdate = TextEditingController();
  final _allergies = TextEditingController();
  final _bloodType = TextEditingController();
  final _gender = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberTableProvider>();
    final dio = Dio();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Nuevo Miembro'),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 240,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Foto de Perfil',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(2.0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: imageProductController.text.isEmpty
                                        ? const Icon(
                                            Icons.person_outline_rounded,
                                            size: 50,
                                          )
                                        : Image.file(
                                            File(
                                                'lib/assets/tmp/${imageProductController.text}'),
                                            fit: BoxFit.fitHeight,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();
                                      if (result != null) {
                                        String? filePath =
                                            result.files.single.path;
                                        if (filePath != null) {
                                          File file = File(filePath);
                                          String newPath =
                                              'lib/assets/tmp/${result.files.single.name}';
                                          await file.copy(newPath);
                                          setState(() {
                                            imageProductController.text =
                                                result.files.single.name;
                                          });
                                        }
                                      }
                                    },
                                    child: const Text('Seleccionar Foto'),
                                  ),
                                )
                              ],
                            ),
                            //huella dactilar
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Huella Dactilar',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Tomar Huella'),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Nombre',
                            hintText: 'Nombre del miembro',
                            emptyValueError: 'Por favor ingrese un nombre',
                            isEmpty: true,
                            onChanged: (value) {
                              _name.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa un nombre';
                              }
                              return null;
                            },
                          )),
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Apellido',
                            hintText: 'Apellido del miembro',
                            isEmpty: true,
                            emptyValueError: 'Por favor ingrese un apellido',
                            onChanged: (value) {
                              _lastname.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa un apellido';
                              }
                              return null;
                            },
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Numero de Telefono',
                            hintText: 'Numero de telefono del miembro',
                            isEmpty: true,
                            emptyValueError:
                                'Por favor ingrese un numero de telefono',
                            onChanged: (value) {
                              _phoneNumber.text = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa un numero de telefono';
                              }
                              return null;
                            },
                          )),
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Nombre del Contacto de Emergencia',
                            hintText: 'Nombre del contacto de emergencia',
                            onChanged: (value) {
                              _emergencyContactName.text = value;
                            },
                          )),
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Contacto de Emergencia',
                            hintText:
                                'numero de telefono del contacto de emergencia',
                            onChanged: (value) {
                              _emergencyContactPhone.text = value;
                            },
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 70,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: MemberFormWidget(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor selecciona una fecha';
                                }
                                return null;
                              },
                              controller: _birthdate,
                              labelText: 'Fecha de Nacimiento',
                              hintText: 'Fecha de nacimiento del miembro',
                              onTap: () async {
                                DateTime? pickeddate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickeddate != null) {
                                  setState(() {
                                    _birthdate.text =
                                        pickeddate.toString().substring(0, 10);
                                  });
                                }
                              },
                              onChanged: (value) => _birthdate.text = value,
                            ),
                          ),
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Alergias',
                            hintText: 'Alergias del miembro',
                            onChanged: (value) {
                              _allergies.text = value;
                            },
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 70,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 190.0,
                                child: MemberFormWidget(
                                  labelText: 'Tipo de Sangre',
                                  hintText: 'Tipo de sangre del miembro',
                                  onChanged: (value) {
                                    _bloodType.text = value;
                                  },
                                )),
                            SizedBox(
                              width: 200,
                              child: MemberFormWidget(
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Por favor selecciona un genero';
                                  }
                                  return null;
                                },
                                controller: _gender,
                                labelText: 'Genero',
                                hintText: 'Genero del miembro',
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position: const RelativeRect.fromLTRB(
                                        350, 700, 300, 300),
                                    items: const [
                                      PopupMenuItem(
                                        value: 'Masculino',
                                        child: Text('Masculino'),
                                      ),
                                      PopupMenuItem(
                                        value: 'Femenino',
                                        child: Text('Femenino'),
                                      ),
                                      PopupMenuItem(
                                        value: 'Otro',
                                        child: Text('Otro'),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value != null) {
                                      _gender.text = value.toString();
                                    }
                                  });
                                },
                                onChanged: (p0) {},
                              ),
                            ),
                            Expanded(
                                child: MemberFormWidget(
                              labelText: 'Email',
                              hintText: 'Email del miembro',
                              onChanged: (value) {
                                _email.text = value;
                              },
                            )),
                          ],
                        )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 20.0),
                          child: FilledButton(
                            child: const Row(
                              children: [
                                Icon(Icons.save),
                                SizedBox(width: 10.0),
                                Text('Guardar'),
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == false) {
                                return;
                              }
                              final isPasswordCorrect =
                                  await showPasswordDialog(context);
                              if (isPasswordCorrect == false) {
                                if (context.mounted) {
                                displayMessageDialog(context, 'Contraseña incorrecta');
                                }
                                return;
                              }

                              final memberData = {
                                'name': _name.text,
                                'last_name': _lastname.text,
                                'phone_number': int.tryParse(_phoneNumber.text),
                                'email': _email.text,
                                'date_of_birth': _birthdate.text,
                                'gender': _gender.text,
                                'emergency_contact_name':
                                    _emergencyContactName.text,
                                'emergency_contact_number':
                                    int.tryParse(_emergencyContactPhone.text),
                                'allergies': _allergies.text,
                                'blood_type': _bloodType.text,
                                'porfileImage': imageProductController.text,
                              };

                              try {
                                await dio.post(
                                  'http://localhost:3569/member/add',
                                  data: memberData,
                                  options: Options(
                                    headers: {
                                      'Content-Type': 'application/json',
                                    },
                                  ),
                                );

                                memberProvider.refresh();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                displayMessageDialog(
                                    context, 'Error al guardar el miembro');
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 20.0, bottom: 20.0),
                            child: FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.cancel_outlined),
                                    SizedBox(width: 10.0),
                                    Text('Cancelar'),
                                  ],
                                ))),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ));
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
