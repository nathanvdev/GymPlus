import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/screens/widgets/display_menu.dart';

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
    _future = Future.value();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      children: const [
                        Center(child: Text("Caja")),
                        Center(child: Text("Gastos Varios")),
                        Center(child: Text("Empleados")),
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
