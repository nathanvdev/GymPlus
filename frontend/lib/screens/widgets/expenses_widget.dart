// import 'package:flutter/material.dart';
// import 'package:frontend/providers/expense_provider.dart';
// import 'package:frontend/screens/widgets/expense_widget.dart';
// import 'package:frontend/utils/auth.dart';
// import 'package:frontend/utils/show_dialog.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ExpensesWidget extends StatelessWidget {
//    ExpensesWidget({
//     super.key,
//     required this.expensesProvider,
//     required this.typeEdition
//   });

//   final ExpenseProvider expensesProvider;
//   var typeEdition;

  

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//           crossAxisAlignment:
//               CrossAxisAlignment.center,
//           children: [
//             Text(
//               "Registro de Gastos Varios",
//               style: GoogleFonts.pridi(
//                 fontSize: 30,
//                 color: Theme.of(context)
//                     .shadowColor
//                     .withOpacity(0.4),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             FilledButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return ExpensesWidget(
//                       type: 1,
//                     );
//                   },
//                 );
//               },
//               child: const Text('Agregar Gasto'),
//             ),
//             SizedBox(
//               width: 200,
//               height: 30,
//               child: SearchBar(
//                 hintText: 'Buscar',
//                 onChanged: (value) {
//                   expensesProvider
//                       .filtringExpenses(value);
//                 },
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height *
//               0.5,
//           width: MediaQuery.of(context).size.width *
//               0.68,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: DataTable(
//               columnSpacing: 1,
//               dividerThickness: 0.2,
//               horizontalMargin: 10,
//               headingRowHeight: 35,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).canvasColor,
//               ),
//               border: TableBorder.all(
//                   color: Theme.of(context)
//                       .shadowColor
//                       .withOpacity(0.5),
//                   width: 1,
//                   borderRadius:
//                       BorderRadius.circular(10),
//                   style: BorderStyle.none),
//               dataRowColor:
//                   const WidgetStatePropertyAll(
//                       Colors.white),
//               columns: const [
//                 DataColumn(label: Text('id')),
//                 DataColumn(label: Text('Nombre')),
//                 DataColumn(
//                     label: Text('Descripcion')),
//                 DataColumn(label: Text('Total')),
//                 DataColumn(label: Text('Vendedor')),
//                 DataColumn(label: Text('Fecha')),
//                 DataColumn(label: Text('Estado')),
//                 DataColumn(label: Text('Acciones')),
//               ],
//               rows: expensesProvider
//                   .filteredExpenseList.reversed
//                   .map((expense) {
//                 return DataRow(
//                   cells: <DataCell>[
//                     DataCell(
//                         Text(expense.id.toString())),
//                     DataCell(Text(expense.name)),
//                     DataCell(
//                         Text(expense.description)),
//                     DataCell(
//                         Text('Q. ${expense.amount}')),
//                     DataCell(Text(expense.supplier)),
//                     DataCell(Text(expense.date)),
//                     DataCell(
//                       Container(
//                         height: 25,
//                         width: 90,
//                         padding:
//                             const EdgeInsets.only(
//                                 left: 5, right: 5),
//                         decoration: BoxDecoration(
//                           color: expense.status == 1
//                               ? Colors.green
//                               : expense.status == 2
//                                   ? Colors.yellow
//                                   : Colors.red,
//                           borderRadius:
//                               BorderRadius.circular(
//                                   10),
//                           border: Border.all(
//                             color:
//                                 const Color.fromARGB(
//                                     255, 0, 0, 0),
//                             width: 1,
//                           ),
//                         ),
//                         child: Center(
//                             child: Text(
//                           expense.status == 1
//                               ? 'Pagado'
//                               : expense.status == 2
//                                   ? 'Pendiente'
//                                   : 'Anulado',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight:
//                                 FontWeight.bold,
//                           ),
//                         )),
//                       ),
//                     ),
//                     DataCell(
//                       expense.status == 3
//                               ? const SizedBox()
//                               : Row(
//                         mainAxisAlignment: MainAxisAlignment
//                             .center,
//                         children: [
//                           IconButton(
//                                   icon: const Icon(
//                                       Icons.edit),
//                                   onPressed: () {
//                                     showDialog(
//                                       context:
//                                           context,
//                                       builder:
//                                           (context) {
//                                         return ExpensesWidget(
//                                           type: typeEdition,
//                                           expenseID:
//                                               expense.id,
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               IconButton(
//                                   icon: const Icon(
//                                       Icons.delete),
//                                   onPressed:
//                                       () async {
//                                     var auth =
//                                         await showPasswordVerificationDialog(
//                                             context);
//                                     if (auth) {
//                                       expensesProvider
//                                           .deleteExpense(
//                                               expense
//                                                   .id);
//                                     } else {
//                                       showDialogMessage(
//                                         context, 'Error',
//                                         'Contraseña incorrecta',
//                                       );
//                                     }
//                                   },
//                                 ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
