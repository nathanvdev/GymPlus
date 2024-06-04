
import 'package:flutter/material.dart';
import 'package:frontend/screens/widgets/display_menu.dart';
import 'package:pluto_grid/pluto_grid.dart';

List<BoxShadow> buildShadowBox() {
  return List<BoxShadow>.generate(
    3,
    (int index) => BoxShadow(
      color: Colors.black.withOpacity(0.3),
      spreadRadius: 1,
      blurRadius: 9,
      offset: const Offset(5, 5),
    ),
  );
}

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
                    top: 40, left: 20, right: 20, bottom: 20),
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
                  margin: const EdgeInsets.only(left: 15),
                  child:  Column(
                      // Removed const
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         const Row(
                          children: [
                             SmallCardWidget(),
                             SmallCardWidget(),
                             SmallCardWidget(),
                             SmallCardWidget(),
                             SmallCardWidget(),
                            
                          ],
                        ),
                        const SizedBox(height: 20),
                       Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(30),
                        child: PlutoGrid(
                            columns: columns,
                            rows: rows,
                            onChanged: (PlutoGridOnChangedEvent event) {
                              print(event);
                            },
                            onLoaded: (PlutoGridOnLoadedEvent event) {
                              print(event);
                            }
                        ),
                      ),
                        const SizedBox(height: 20),
                        const Text(
                            "Si tienes alguna duda, puedes contactar con el soporte tecnico",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        const SizedBox(height: 20),
                        const Text("Gracias por confiar en nosotros",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        const SizedBox(height: 20),
                      ]),
                )),
          ],
        )),
      ),
    );
  }
  
List<PlutoColumn> columns = [

  /// Text Column definition
  PlutoColumn(
    title: 'text column',
    field: 'text_field',
    type: PlutoColumnType.text(),
  ),

  /// Number Column definition
  PlutoColumn(
    title: 'number column',
    field: 'number_field',
    type: PlutoColumnType.number(),
  ),

  /// Select Column definition
  PlutoColumn(
    title: 'select column',
    field: 'select_field',
    type: PlutoColumnType.select(['item1', 'item2', 'item3']),
  ),

  /// Datetime Column definition
  PlutoColumn(
    title: 'date column',
    field: 'date_field',
    type: PlutoColumnType.date(),
  ),

  /// Time Column definition
  PlutoColumn(
    title: 'time column',
    field: 'time_field',
    type: PlutoColumnType.time(),
  ),
];

List<PlutoRow> rows = [
  PlutoRow(
    cells: {
      'text_field': PlutoCell(value: 'Text cell value1'),
      'number_field': PlutoCell(value: 2020),
      'select_field': PlutoCell(value: 'item1'),
      'date_field': PlutoCell(value: '2020-08-06'),
      'time_field': PlutoCell(value: '12:30'),
    },
  ),
  PlutoRow(
    cells: {
      'text_field': PlutoCell(value: 'Text cell value2'),
      'number_field': PlutoCell(value: 2021),
      'select_field': PlutoCell(value: 'item2'),
      'date_field': PlutoCell(value: '2020-08-07'),
      'time_field': PlutoCell(value: '18:45'),
    },
  ),
  PlutoRow(
    cells: {
      'text_field': PlutoCell(value: 'Text cell value3'),
      'number_field': PlutoCell(value: 2022),
      'select_field': PlutoCell(value: 'item3'),
      'date_field': PlutoCell(value: '2020-08-08'),
      'time_field': PlutoCell(value: '23:59'),
    },
  ),
];
}

class SmallCardWidget extends StatelessWidget {
  const SmallCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
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
            padding: EdgeInsets.only(left: 8.0),
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
