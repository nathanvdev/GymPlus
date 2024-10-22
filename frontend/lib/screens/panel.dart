import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/models/member.dart';
import 'package:frontend/screens/member_profile.dart';
import 'package:frontend/screens/new_member.dart';
import 'package:frontend/providers/member_table.provider.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:provider/provider.dart';

import 'widgets/body_measurements.dart';
import 'widgets/payment_process_widget.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dashboard();
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => Dashboardstate();
}

class Dashboardstate extends State<Dashboard> {

  Future<void> _future = Future.any([]);

  @override
  void initState() {
    super.initState();
    _future = context.read<MemberTableProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.read<MemberTableProvider>();
    final memberselectedProvider = context.read<MemberSelectedProvider>();
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
                      Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10, left: 20),
                            child: Column(
                                // Removed const
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const TopBanner(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FilledButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const NewMemberScreen()));
                                                    },
                                                    child: const Text(
                                                        "Agregar Miembro"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FilledButton(
                                                    onPressed: () {
                                                      if (memberselectedProvider
                                                              .getSelectedMemberId() ==
                                                          -1) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Error'),
                                                              content: const Text(
                                                                  'Seleccione un miembro para realizar el pago'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      'Aceptar'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const PaymentProcessWidget(
                                                                type: 1);
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: const Text(
                                                        "Realizar Pago"),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FilledButton(
                                                    onPressed: () {
                                                      if (memberselectedProvider
                                                              .getSelectedMemberId() ==
                                                          -1) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Error'),
                                                              content: const Text(
                                                                  'Seleccione un miembro para realizar la medición'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      'Aceptar'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                      else {
                                                       showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const BodyMeasurements();
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: const Text(
                                                        "Medición Antropométrica"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SearchBar(
                                                  hintText: "Buscar Miembro",
                                                  shadowColor:
                                                      WidgetStatePropertyAll(
                                                    Theme.of(context)
                                                        .shadowColor,
                                                  ),
                                                  elevation:
                                                      const WidgetStatePropertyAll(
                                                          8),
                                                  shape: WidgetStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      side: BorderSide(
                                                        color: Theme.of(context)
                                                            .shadowColor,
                                                      ),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    memberProvider
                                                        .filtringMembers(value);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const TableWdgt(),
                                ]),
                          )),
                    ],
                  );
          },
        ),
      ),
    );
  }

  SizedBox actionsButtons(
      BuildContext context,
      MemberSelectedProvider memberselectedProvider,
      MemberTableProvider memberProvider) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewMemberScreen()));
                      },
                      child: const Text("Agregar Miembro"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        if (memberselectedProvider.getSelectedMemberId() ==
                            -1) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Seleccione un miembro para realizar el pago'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const PaymentProcessWidget(type: 1);
                            },
                          );
                        }
                      },
                      child: const Text("Realizar Pago"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      onPressed: () {
                        if (memberselectedProvider.getSelectedMemberId() ==
                            -1) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text(
                                    'Seleccione un miembro para realizar la medición'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text("Medición Antropométrica"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    hintText: "Buscar Miembro",
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
                      memberProvider.filtringMembers(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.59,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
        ),
        child: const Text('Banner'));
  }
}

class TableWdgt extends StatefulWidget {
  const TableWdgt({
    super.key,
  });

  @override
  TableWdgtState createState() => TableWdgtState();
}

class TableWdgtState extends State<TableWdgt> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        if (event.localPosition.dx > MediaQuery.of(context).size.width * 0.7) {
          _scrollController.animateTo(
            _scrollController.offset + 1000,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else if (event.localPosition.dx <
            MediaQuery.of(context).size.width * 0.1) {
          _scrollController.animateTo(
            _scrollController.offset - 1000,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 5)),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1384, maxWidth: 1384),
              child: const MembersTable(),
            ),
          ),
        ),
      ),
    );
  }
}

class MembersTable extends StatefulWidget {
  const MembersTable({
    super.key,
  });

  @override
  MembersTableState createState() => MembersTableState();
}

class MembersTableState extends State<MembersTable> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final memberProvider = context.watch<MemberTableProvider>();
    final memberselectedProvider = context.read<MemberSelectedProvider>();

    return DataTable(
      onSelectAll: (val) {
        setState(() {
          memberselectedProvider.setSelectedMemberId(-1);
        });
      },
      showBottomBorder: true,
      columnSpacing: 1,
      headingRowHeight: 50,
      dataRowMinHeight: 60,
      dataRowMaxHeight: 60,
      showCheckboxColumn: false,
      horizontalMargin: 10,
      columns: const <DataColumn>[
        //fot de perfil
        DataColumn(label: Center(child: Text('Nombre'))),
        DataColumn(label: Center(child: Text('Estado'))),
        DataColumn(
            label: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ultimo'),
            Text('Pago'),
          ],
        )),
        DataColumn(
            label: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Proximo'),
            Text('Pago'),
          ],
        )),
        DataColumn(
            label: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tiempo'),
            Text('Activo'),
          ],
        )),
        DataColumn(
          label: Text(''),
        ),
      ],
      rows: memberProvider.filtredMemberList.map((Member member) {
        return DataRow(
            color: WidgetStateProperty.all<Color>(
              member.id == memberselectedProvider.getSelectedMemberId()
                  ? Colors.orange[100]!
                  : member.id.isEven
                      ? Colors.red[100]!
                      : Colors.blue[100]!,
            ),
            selected: member.id == memberselectedProvider.getSelectedMemberId(),
            onSelectChanged: (value) {
              setState(() {
                if (memberselectedProvider.getSelectedMemberId() == member.id) {
                  memberselectedProvider.setSelectedMemberId(-1);
                } else {
                  memberselectedProvider.setSelectedMemberId(member.id);
                }
              });
            },
            cells: [
              DataCell(Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: member.porfileImage != ''
                            ? FileImage(File('lib/assets/tmp/${member.porfileImage}'))
                            : const AssetImage('lib/assets/defaultprofile.webp'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(member.name),
                      Text(member.lastname),
                    ],
                  ),
                ],
              )),
              if (member.membershipStatus == "Activo")
                const DataCell(Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Activo'),
                    ),
                  ],
                ))
              else if (member.membershipStatus == "Por Vencer")
                const DataCell(Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.yellow,
                      size: 30,
                      shadows: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Por Vencer'),
                    ),
                  ],
                ))
              else
                const DataCell(Row(
                  children: [
                    Icon(
                      Icons.do_not_disturb_on_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Inactivo'),
                    ),
                  ],
                )),
              DataCell(Text(member.lastPaymentDate)),
              DataCell(Text(member.nextPaymentDate)),
              DataCell(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(member.activeDays),
                ],
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewMemberScreen(type: 2, memberID: member.id)));
                      
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      memberselectedProvider.setSelectedMemberId(member.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MemberProfile()));
                    },
                  ),
                ],
              )),
            ]);
      }).toList(),
    );
  }
}

class SmallCardWidget extends StatelessWidget {
  const SmallCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: buildShadowBox(),
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(
              "200",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 40,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 10),
            child: Text(
              "Miembros Activos",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
