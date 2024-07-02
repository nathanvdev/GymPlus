import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';

import 'package:frontend/models/member.dart';
import 'package:frontend/screens/new_member.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/member_table_provider.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:frontend/screens/widgets/member_form_widget.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final memberProvider = context.read<MemberTableProvider>();
    final memberselectedProvider = context.read<MemberSelectedProvider>();
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
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: buildShadowBox(),
                ),
                child: const Menu(), // Removed const
              ),
            )),
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
                                                    builder: (context) =>
                                                        const NewMemberScreen()));
                                          },
                                          child: const Text("Agregar Miembro"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FilledButton(
                                          onPressed: () {
                                            if (memberselectedProvider
                                                    .getSelectedMemberId() ==
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
                                                          Navigator.of(context)
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
                                                  return const PaymentProcessWidget();
                                                },
                                              );
                                              print(
                                                  "Realizar Pago ${memberselectedProvider.getSelectedMemberId()} ");
                                            }
                                          },
                                          child: const Text("Realizar Pago"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FilledButton(
                                          onPressed: () {
                                            if (memberselectedProvider
                                                    .getSelectedMemberId() ==
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
                                                          Navigator.of(context)
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
                                            print(
                                                "Medición Antropométrica ${memberselectedProvider.getSelectedMemberId()} ");
                                          },
                                          child: const Text(
                                              "Medición Antropométrica"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SearchBar(
                                        hintText: "Buscar Miembro",
                                        shadowColor: WidgetStatePropertyAll(
                                          Theme.of(context).shadowColor,
                                        ),
                                        elevation:
                                            const WidgetStatePropertyAll(8),
                                        shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: BorderSide(
                                              color:
                                                  Theme.of(context).shadowColor,
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
                        ),
                        const TableWdgt(),
                      ]),
                )),
          ],
        )),
      ),
    );
  }
}

class PaymentProcessWidget extends StatefulWidget {
  const PaymentProcessWidget({super.key});

  @override
  State<PaymentProcessWidget> createState() => _PaymentProcessState();
}

class _PaymentProcessState extends State<PaymentProcessWidget> {
  final TextEditingController _initialDate = TextEditingController();
  final TextEditingController _finalDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double billingQuantity = 1;
  double billingRate = 1;

  @override
  Widget build(BuildContext context) {
    final memberselectedProvider = context.read<MemberSelectedProvider>();
    final memberProvider = context.read<MemberTableProvider>();
    final loginProvider = context.read<LoginProvider>();

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
                        // initialValue: memberselectedProvider.getSelectedMemberId().toString(),
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          hintText: "Nombre del miembro",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownMenu(
                          expandedInsets: EdgeInsets.all(10),
                          label: Text('Tipo de Membresia'),
                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: 0, label: 'Standard')
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 0),
                          child: Text(
                            "Duracion",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: billingQuantity,
                            min: 1,
                            max: 30,
                            allowedInteraction: SliderInteraction.tapAndSlide,
                            divisions: 30,
                            label: billingQuantity.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                billingQuantity = value;
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
                            "Intervalo",
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
                                billingRate = value;
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
                                .add(const Duration(days: 30))
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+.\d?$')),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Descuento",
                        hintText: "Descuento a aplicar",
                        border: OutlineInputBorder(),
                      ),
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
                      decoration: const InputDecoration(
                        labelText: "Descripcion",
                        hintText: "Descripcion del descuento",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una cantidad';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Metodo de pago",
                        hintText: "Selecione el metodo de pago",
                        border: OutlineInputBorder(),
                      ),
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
                      decoration: const InputDecoration(
                        labelText: "Estado del pago",
                        hintText: "Seleccione el estado del pago",
                        border: OutlineInputBorder(),
                      ),
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
            Navigator.of(context).pop();
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
        child: FlutterCarousel.builder(
            itemCount: 4,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmallCardWidget(),
                  SmallCardWidget(),
                  SmallCardWidget(),
                ],
              );
            },
            options: CarouselOptions(
                autoPlayCurve: Curves.easeInCubic,
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 7),
                enableInfiniteScroll: true,
                slideIndicator: CircularSlideIndicator(
                  indicatorBackgroundColor: Colors.white,
                  indicatorBorderColor: Colors.black,
                  indicatorRadius: 5,
                  indicatorBorderWidth: 1,
                  currentIndicatorColor: Theme.of(context).shadowColor,
                ))));
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
                Border.all(color: Theme.of(context).primaryColor, width: 3)),
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
      checkboxHorizontalMargin: 2,
      showBottomBorder: true,
      columnSpacing: 0,
      headingRowHeight: 50,
      dataRowMinHeight: 60,
      dataRowMaxHeight: 60,
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
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 30,
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
              if (member.membershipStatus == "Active")
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
              const DataCell(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('12'),
                  Text('Meses'),
                ],
              )),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {},
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
