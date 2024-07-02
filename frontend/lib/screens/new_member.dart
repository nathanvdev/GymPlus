import 'package:flutter/material.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/member_table_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'widgets/member_form_widget.dart';

class NewMemberScreen extends StatefulWidget {
  const NewMemberScreen({super.key});
  @override
  State<NewMemberScreen> createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  final TextEditingController _birthdate = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _name;
  late String _lastname;
  late String _phoneNumber;
  String _emergencyContactName = '';
  String _emergencyContactPhone = '';
  String _allergies = '';
  String _bloodType = '';
  String _date = '';
  String _email = '';


  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberTableProvider>();
    final loginProvider = context.read<LoginProvider>();
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Seleccionar Foto'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Tomar Foto'),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 170,
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
                              _name = value;
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
                              _lastname = value;
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
                              _phoneNumber = value;
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
                              _emergencyContactName = value;
                            },
                          )),
                          Expanded(
                              child: MemberFormWidget(
                            labelText: 'Contacto de Emergencia',
                            hintText:
                                'numero de telefono del contacto de emergencia',
                            onChanged: (value) {
                              _emergencyContactPhone = value;
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
                                    _date = _birthdate.text;
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
                              _allergies = value;
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
                                    _bloodType = value;
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
                                        position: const RelativeRect.fromLTRB(350, 700, 300, 300),
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
                                        _gender.text =value.toString();
                                        }
                                      });
                                    },
                                    onChanged: (p0) {
                                      
                                    },
                                  ),
                                ),
                            Expanded(
                                child: MemberFormWidget(
                              labelText: 'Email',
                              hintText: 'Email del miembro',
                              onChanged: (value) {
                                _email = value;
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == false) {
                                return;
                              }

                              bool isPasswordVisible = false;
                              final memberData = {
                                'name': _name,
                                'last_name': _lastname,
                                'phone_number': int.tryParse(_phoneNumber),
                                'email': _email,
                                'date_of_birth': _date,
                                'gender': _gender.text,
                                'emergency_contact_name': _emergencyContactName,
                                'emergency_contact_number':
                                    int.tryParse(_emergencyContactPhone),
                                'allergies': _allergies,
                                'blood_type': _bloodType,
                              };
                              String password = '';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Verifica tus datos'),
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            initialValue:
                                                loginProvider.getUsername(),
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              labelText: 'Username',
                                              hintText: 'Ingresa tu usuario',
                                              prefixIcon: Icon(
                                                  Icons.person_outline_rounded),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                                hintText:
                                                    'Ingresa tu contraseña',
                                                prefixIcon: const Icon(
                                                    Icons.lock_outline_rounded),
                                                border:
                                                    const OutlineInputBorder(),
                                                suffixIcon: IconButton(
                                                  icon: Icon(isPasswordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                                  onPressed: () {
                                                    setState(() {
                                                      isPasswordVisible =
                                                          !isPasswordVisible;
                                                    });
                                                  },
                                                )),
                                            onChanged: (value) {
                                              password = '';
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
                                          if (password ==
                                              loginProvider.user.password) {
                                            try {
                                              await dio.post(
                                                'http://localhost:3569/member/add',
                                                data: memberData,
                                                options: Options(
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json',
                                                  },
                                                ),
                                              );

                                              memberProvider.refresh();
                                              Navigator.pop(context);
                                            } catch (e) {
                                              Navigator.pop(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text('Error'),
                                                    content: const Text(
                                                        'Hubo un error al guardar el miembro'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Aceptar'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Contraseña Incorrecta'),
                                                  content: const Text(
                                                      'La contraseña ingresada no coincide con la de tu usuario'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Aceptar'),
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
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.save),
                                SizedBox(width: 10.0),
                                Text('Guardar'),
                              ],
                            ),
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
}
