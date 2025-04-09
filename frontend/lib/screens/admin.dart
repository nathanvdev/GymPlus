import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/providers/transaction_provider.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:frontend/screens/widgets/stats_payment_card.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminPage();
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  Future<void> _future = Future.any([]);
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _future = _initData();
  }

  Future<void> _initData() async {
    await context.read<TransactionProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();

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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          expandedHeight: 00,
                          systemOverlayStyle: SystemUiOverlayStyle.dark,
                          pinned: true,
                          floating: true,
                          bottom: TabBar(
                            dividerHeight: 2,
                            indicatorColor: Colors.white,
                            indicatorWeight: 4,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            mouseCursor: WidgetStateMouseCursor.clickable,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            enableFeedback: true,
                            indicatorAnimation: TabIndicatorAnimation.elastic,
                            labelStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            controller: _tabController,
                            tabs: const [
                              Tab(
                                text: "Caja",
                                icon: Icon(Icons.money),
                              ),
                              Tab(
                                text: "Gastos Varios",
                                icon: Icon(Icons.money_off),
                              ),
                              Tab(
                                text: "Empleados",
                                icon: Icon(Icons.people),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const StatsCash(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.57,
                              width: MediaQuery.of(context).size.width * 0.76,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 5)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                    showBottomBorder: true,
                                    columnSpacing: 1,
                                    headingRowHeight: 50,
                                    dataRowMinHeight: 60,
                                    dataRowMaxHeight: 60,
                                    showCheckboxColumn: false,
                                    horizontalMargin: 10,
                                    columns: const [
                                      DataColumn(label: Text("Descripcion")),
                                      DataColumn(label: Text("Debito")),
                                      DataColumn(label: Text("Credito")),
                                      DataColumn(label: Text("Fecha")),
                                    ],
                                    rows: transactionProvider.transactionList
                                        .map((transaction) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                              Text(transaction.descripcion)),
                                          DataCell(Text(
                                              transaction.debito.toString())),
                                          DataCell(Text(
                                              transaction.credito.toString())),
                                          DataCell(Text(transaction.fecha)),
                                        ],
                                      );
                                    }).toList()),
                              ),
                            )
                          ],
                        ),
                        const Center(child: Text("En desarrollo")),
                        const Center(child: Text("En desarrollo")),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
