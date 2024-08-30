import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/providers/payments.provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/display_menu.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymplus App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightMode(),
      home: const _PaymentsPagState(),
    );
  }
}

class _PaymentsPagState extends StatefulWidget {
  const _PaymentsPagState({super.key});

  @override
  State<_PaymentsPagState> createState() => __PaymentsPagStateState();
}

class __PaymentsPagStateState extends State<_PaymentsPagState> {
  @override
  Widget build(BuildContext context) {
    final paymentsProvider = context.watch<PaymentsProvider>();

    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Row(
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
                    SizedBox(
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
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.76,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('No. Pago')),
                          DataColumn(label: Text('Miembro')),
                          DataColumn(label: Text('Ciclo')),
                          DataColumn(label: Text('Cantidad')),
                          DataColumn(label: Text('Fecha de Pago')),
                          DataColumn(label: Text('Estado')),
                          DataColumn(label: Text('')),
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
                              DataCell(Text(billingRateToString(payment.billingQuantity))),
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
                                  payment.paymentStatus == 1
                                      ? 'Pagado'
                                      : 'Pendiente',
                                    )),
                              )),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {},
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
                        // rows: <DataRow>[
                        //   DataRow(
                        //     cells: <DataCell>[
                        //       const DataCell(Text('123456')),
                        //       const DataCell(Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text('Sarah'),
                        //           Text('Gonzales'),
                        //         ],
                        //       )),
                        //       const DataCell(Text('Mes')),
                        //       const DataCell(Text('100')),
                        //       const DataCell(Text('2021-10-10')),
                        //       DataCell(Container(
                        //         height: 30,
                        //         width: 80,
                        //         padding:
                        //             const EdgeInsets.only(left: 5, right: 5),
                        //         decoration: BoxDecoration(
                        //           color: Colors.green,
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //             color: const Color.fromARGB(255, 0, 0, 0),
                        //             width: 2,
                        //           ),
                        //         ),
                        //         child: const Center(
                        //             child: Text(
                        //           'Pagado',
                        //           style: TextStyle(
                        //               color:
                        //                   Color.fromARGB(255, 255, 255, 255)),
                        //         )),
                        //       )),
                        //       DataCell(
                        //         Row(
                        //           children: [
                        //             IconButton(
                        //               icon: const Icon(Icons.edit),
                        //               onPressed: () {},
                        //             ),
                        //             IconButton(
                        //               icon: const Icon(Icons.delete),
                        //               onPressed: () {},
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   DataRow(
                        //     cells: <DataCell>[
                        //       const DataCell(Text('34232')),
                        //       const DataCell(Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text('James'),
                        //           Text('Tziquin'),
                        //         ],
                        //       )),
                        //       const DataCell(Text('Mes')),
                        //       const DataCell(Text('100')),
                        //       const DataCell(Text('2021-10-10')),
                        //       DataCell(Container(
                        //         height: 30,
                        //         width: 80,
                        //         padding:
                        //             const EdgeInsets.only(left: 5, right: 5),
                        //         decoration: BoxDecoration(
                        //           color: Colors.yellow,
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //             color: const Color.fromARGB(255, 0, 0, 0),
                        //             width: 2,
                        //           ),
                        //         ),
                        //         child: const Center(
                        //             child: Text(
                        //           'Pendiente',
                        //           style: TextStyle(
                        //               color: Color.fromARGB(255, 0, 0, 0)),
                        //         )),
                        //       )),
                        //       DataCell(
                        //         Row(
                        //           children: [
                        //             IconButton(
                        //               icon: const Icon(Icons.edit),
                        //               onPressed: () {},
                        //             ),
                        //             IconButton(
                        //               icon: const Icon(Icons.delete),
                        //               onPressed: () {},
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   DataRow(
                        //     cells: <DataCell>[
                        //       const DataCell(Text('4562452134')),
                        //       const DataCell(Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Text('Jhon'),
                        //           Text('Smith'),
                        //         ],
                        //       )),
                        //       const DataCell(Text('Mes')),
                        //       const DataCell(Text('100')),
                        //       const DataCell(Text('2021-10-10')),
                        //       DataCell(Container(
                        //         height: 30,
                        //         width: 80,
                        //         padding:
                        //             const EdgeInsets.only(left: 5, right: 5),
                        //         decoration: BoxDecoration(
                        //           color: Colors.green,
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //             color: const Color.fromARGB(255, 0, 0, 0),
                        //             width: 2,
                        //           ),
                        //         ),
                        //         child: const Center(
                        //             child: Text(
                        //           'Pagado',
                        //           style: TextStyle(
                        //               color:
                        //                   Color.fromARGB(255, 255, 255, 255)),
                        //         )),
                        //       )),
                        //       DataCell(
                        //         Row(
                        //           children: [
                        //             IconButton(
                        //               icon: const Icon(Icons.edit),
                        //               onPressed: () {},
                        //             ),
                        //             IconButton(
                        //               icon: const Icon(Icons.delete),
                        //               onPressed: () {},
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ],
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                        ),
                        border: TableBorder.all(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.5),
                            width: 1,
                            borderRadius: BorderRadius.circular(10),
                            style: BorderStyle.none),
                        dataRowColor:
                            const WidgetStatePropertyAll(Colors.white),
                        // headingRowColor: WidgetStatePropertyAll(Color.fromARGB(255, 87, 87, 87)),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.76,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
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
