import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/providers/login_provider.dart';
import 'package:frontend/screens/providers/payments_provider.dart';
import 'package:frontend/screens/providers/sales_provider.dart';
import 'package:frontend/screens/widgets/payment_process_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/display_menu.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SalesProvider()),
    ], child: const _PaymentsPagState());
  }
}

class _PaymentsPagState extends StatefulWidget {
  const _PaymentsPagState();

  @override
  State<_PaymentsPagState> createState() => __PaymentsPagStateState();
}

class __PaymentsPagStateState extends State<_PaymentsPagState> {
  Future<void> _future = Future.any([]);

  @override
  void initState() {
    super.initState();
    _future = _initData();
  }

  Future<void> _initData() async {
    await context.read<PaymentsProvider>().refresh();
    await context.read<SalesProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final paymentsProvider = context.watch<PaymentsProvider>();
    final salesProvider = context.watch<SalesProvider>();

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
                    width: MediaQuery.of(context).size.width * 0.21,
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
                    width: MediaQuery.of(context).size.width * 0.79,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          statasSection(context),
                          membershipsSection(context, paymentsProvider),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.76,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ventas de Tienda',
                                  style: GoogleFonts.pridi(
                                    fontSize: 30,
                                    color: Theme.of(context)
                                        .shadowColor
                                        .withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.76,
                                  child: DataTable(
                                    columnSpacing: 1,
                                    dividerThickness: 0.2,
                                    horizontalMargin: 10,
                                    headingRowHeight: 35,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    border: TableBorder.all(
                                        color: Theme.of(context)
                                            .shadowColor
                                            .withOpacity(0.5),
                                        width: 1,
                                        borderRadius: BorderRadius.circular(10),
                                        style: BorderStyle.none),
                                    dataRowColor:
                                        const WidgetStatePropertyAll(Colors.white),
                                    columns: const [
                                      DataColumn(label: Text('id')),
                                      DataColumn(label: Text('Total')),
                                      DataColumn(label: Text('Fecha')),
                                      DataColumn(label: Text('Autorizado por')),
                                      DataColumn(label: Text('Acciones')),
                                    ],
                                    rows: salesProvider.filteredSaleList.map((sale) {
                                      return DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(sale.id)),
                                          DataCell(Text('Q. ${sale.total}')),
                                          DataCell(Text(sale.date)),
                                          DataCell(Text(sale.autorizedBy)),
                                          DataCell(
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.delete),
                                                  onPressed: () async {
                                                    var auth =
                                                        await showPasswordDialog(
                                                            context);
                                                    if (auth) {
                                                      salesProvider
                                                          .deleteSale(sale.id);
                                                    } else {
                                                      displayMessageDialog(
                                                        context,
                                                        'Contraseña incorrecta',
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
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

  Container membershipsSection(
      BuildContext context, PaymentsProvider paymentsProvider) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.76,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pagos de Membresias',
                style: GoogleFonts.pridi(
                  fontSize: 30,
                  color: Theme.of(context).shadowColor.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 200,
                height: 30,
                child: SearchBar(
                  hintText: 'Buscar',
                  
                  onChanged: (value) {
                    paymentsProvider.filtringPayments(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.76,
            child: DataTable(
              columnSpacing: 30,
              dividerThickness: 0.2,
              horizontalMargin: 10,
              headingRowHeight: 35,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              border: TableBorder.all(
                  color: Theme.of(context).shadowColor.withOpacity(0.5),
                  width: 1,
                  borderRadius: BorderRadius.circular(10),
                  style: BorderStyle.none),
              dataRowColor: const WidgetStatePropertyAll(Colors.white),
              columns: const <DataColumn>[
                DataColumn(label: Text('# ID')),
                DataColumn(label: Text('Miembro')),
                DataColumn(label: Text('Ciclo')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Fecha de Pago')),
                DataColumn(label: Text('Estado')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: paymentsProvider.filteredPaymentList.map((payment) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(payment.id.toString())),
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(payment.name),
                        Text(payment.lastName),
                      ],
                    )),
                    DataCell(Text(billingRateToString(payment.billingCycle))),
                    DataCell(Text(payment.billingQuantity.toString())),
                    DataCell(Text(payment.createdAt.toString())),
                    DataCell(Container(
                      height: 30,
                      width: 80,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: payment.paymentStatus == 1
                            ? Colors.green
                            : Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 2,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        payment.paymentStatus == 1 ? 'Pagado' : 'Pendiente',
                      )),
                    )),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PaymentProcessWidget(
                                    type: 2,
                                    paymentID: payment.id,
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox statasSection(BuildContext context) {
    return SizedBox(
      height: 235,
      width: MediaQuery.of(context).size.width * 0.76,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StatsPaymentCard(
              title: "Membresias",
              value: "100",
              subtitle: "Membresias Pendientes",
              value1: "200",
              subtitle1: "Membresias Por Vencer"),
          SizedBox(width: 100),
          StatsPaymentCard(
              title: 'Ventas de Tienda',
              value: '300',
              subtitle: 'Productos Vendidos',
              value1: 'ISO100',
              subtitle1: 'Mas Vendido'),
        ],

        // StatsPaymentCard("Membresias", "100", "Membresias Pendientes", "200", "Membresias Por Vencer"),
        // StatsPaymentCard('Ventas de Tienda', '300', 'Productos Vendidos','',''),
      ),
    );
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

class StatsPaymentCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String value1;
  final String subtitle1;
  const StatsPaymentCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.value1,
    required this.subtitle1,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width * 0.23,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).shadowColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: buildShadowBox(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                title,
                style: GoogleFonts.pridi(
                    fontSize: 27,
                    color: const Color.fromARGB(255, 166, 166, 166),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  value,
                  style: GoogleFonts.pridi(
                    fontSize: 33,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  subtitle,
                  style: GoogleFonts.pridi(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 154, 154, 154)),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value1,
                  style: GoogleFonts.pridi(
                    fontSize: 33,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  subtitle1,
                  style: GoogleFonts.pridi(
                    color: const Color.fromARGB(255, 154, 154, 154),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
