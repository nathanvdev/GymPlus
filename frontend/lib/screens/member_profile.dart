import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/membership_payment.dart';
import 'package:frontend/providers/profileview_provider.dart';
import 'package:provider/provider.dart';

import '../providers/member_table.provider.dart';
import 'widgets/payment_process_widget.dart';

class MemberProfile extends StatelessWidget {
  const MemberProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (memberProvider) => ProfileviewProvider(),
      )
    ], child: const _MemberPagState());
  }
}

class _MemberPagState extends StatefulWidget {
  const _MemberPagState();

  @override
  State<_MemberPagState> createState() => __MemberPagStateState();
}

class __MemberPagStateState extends State<_MemberPagState> {
  Future<void> _future = Future.any([]);

  @override
  void initState() {
    super.initState();
    final memberID =
        context.read<MemberSelectedProvider>().getSelectedMemberId();
    final tmpvar = getInitialInfo(memberID);
    _future = Future.any([tmpvar]);
  }

  @override
  Widget build(BuildContext context) {
    final memberProfileProvider = context.watch<ProfileviewProvider>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Member Profile'),
        ),
        body: Center(
          child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                          height: 400,
                          margin: const EdgeInsets.only(
                              left: 70, right: 70, bottom: 10, top: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 178, 178, 178),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: memberProfileProvider.member.profileImage ==
                                                    "N/A" ||
                                                memberProfileProvider.member.profileImage == ''
                                            ? const AssetImage(
                                                'lib/assets/defaultprofile.webp')
                                            : FileImage(File(
                                                'lib/assets/tmp/${memberProfileProvider.member.profileImage}')),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${memberProfileProvider.member.name} ${memberProfileProvider.member.lastname}',
                                        style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          'Miembro desde: ${memberProfileProvider.member.createdAt}'),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          color:
                                              memberProfileProvider.member.membershipStatus ==
                                                      "Activo"
                                                  ? Colors.green
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          memberProfileProvider.member.membershipStatus ==
                                                  "Activo"
                                              ? 'Activo'
                                              : 'Inactivo',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Información de contacto',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(memberProfileProvider.member.phoneNumber),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.email),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(memberProfileProvider.member.email),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.person),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(memberProfileProvider.member.gender),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_month),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(memberProfileProvider.member.birthDate),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Informacion de Emergencia',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Contacto: ${memberProfileProvider.member.emergencyContactName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(memberProfileProvider
                                              .member.emergencyContactNumber),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.warning_amber_outlined),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Alergias: ${memberProfileProvider.member.allergies}'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.bloodtype),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Tipo de Sangre: ${memberProfileProvider.member.bloodType}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Estadisticas',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.attach_money_rounded),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Ultimo Pago: ${memberProfileProvider.member.lastPayment}'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.money),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Proximo Pago: ${memberProfileProvider.member.nextDuePayment}'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Ultima Visita: ${memberProfileProvider.member.lastVisit}'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              'Dias Activos: ${memberProfileProvider.member.activeDays}'),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                        height: 550,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 178, 178, 178),
                                  width: 2,
                                ),
                              ),
                              child: memberProfileProvider.member.payments == null ||
                                      memberProfileProvider.member.payments!.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No hay pagos',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 178, 178, 178),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Historial de Pagos',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight: 450,
                                            ),
                                            child: (memberProfileProvider.member.payments ==
                                                        null ||
                                                    memberProfileProvider.member.payments ==
                                                        [])
                                                ? const Center(
                                                    child: Text('No hay pagos'),
                                                  )
                                                : ListView.builder(
                                                    itemCount: memberProfileProvider.member
                                                        .payments!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return MembershipCard(
                                                        payment: memberProfileProvider.member
                                                            .payments![index],
                                                      );
                                                    },
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                            // TODO: Uncomment this when the API is ready
                            // member.member.measurements!.isEmpty ||
                            //     member.member.measurements == null
                            // ? const Center(
                            //     child: Text('No hay Visitas', style: TextStyle(
                            //       fontSize: 25,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color.fromARGB(255, 178, 178, 178),
                            //     ),),
                            //   )
                            // :
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 178, 178, 178),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Historial de Visitas',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 450,
                                      ),
                                      child: ListView.builder(
                                        itemCount: 15,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.all(5),
                                            padding: const EdgeInsets.all(15),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 178, 178, 178),
                                                width: 2,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      'Visita #$index',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    const Text(
                                                        'Fecha: 2021-10-10'),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    const Text(
                                                        'Hora: 10:00 AM'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 55, right: 55, bottom: 10, top: 10),
                        padding: const EdgeInsets.all(10),
                        height: 450,
                        width: 880,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromARGB(255, 178, 178, 178),
                            width: 2,
                          ),
                        ),
                        child: memberProfileProvider.member.measurements == null ||
                                memberProfileProvider.member.measurements!.isEmpty
                            ? const Center(
                                child: Text(
                                  'No hay mediciones',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 178, 178, 178),
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        'Historial de Mediciones Antropometricas',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DataTable(
                                      columnSpacing: 20,
                                      columns: const [
                                        DataColumn(label: Text('Fecha')),
                                        DataColumn(label: Text('Peso')),
                                        DataColumn(label: Text('Estatura')),
                                        DataColumn(label: Text('IMC')),
                                        DataColumn(label: Text('Biceps')),
                                        DataColumn(label: Text('Pecho')),
                                        DataColumn(label: Text('Cintura')),
                                        DataColumn(label: Text('Muslo')),
                                        DataColumn(label: Text('Pantorrilla')),
                                        DataColumn(label: Text('Acciones')),
                                      ],
                                      rows: (memberProfileProvider.member.measurements ==
                                                  null ||
                                              memberProfileProvider.member.measurements == [])
                                          ? const <DataRow>[]
                                          : List<DataRow>.generate(
                                              memberProfileProvider
                                                  .member.measurements!.length,
                                              (index) => DataRow(cells: [
                                                    DataCell(Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(memberProfileProvider
                                                            .member
                                                            .measurements![
                                                                index]
                                                            .createdAt
                                                            .substring(0, 10)),
                                                        Text(
                                                            '${memberProfileProvider.member.measurements![index].createdAt.substring(11, 16)} hrs'),
                                                      ],
                                                    )),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .weight
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .height
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .imc
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .arm
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .chest
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .abdomen
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .gluteus
                                                        .toString())),
                                                    DataCell(Text(memberProfileProvider
                                                        .member
                                                        .measurements![index]
                                                        .thigh
                                                        .toString())),
                                                    DataCell(Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.edit),
                                                          onPressed: () {},
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () {},
                                                        ),
                                                      ],
                                                    ))
                                                  ])),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }),
        ));
  }

  Future<void> getInitialInfo(int id) async {
    context.read<ProfileviewProvider>().refresh(id);
  }
}

class MembershipCard extends StatelessWidget {
  final MembershipPayment payment;

  const MembershipCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 178, 178, 178),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plan: Plan Standard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Inicio: ${payment.initialPaymentDate}'),
              Text('Fin: ${payment.nextPaymentDate}'),
              Text(
                'Monto: Q ${payment.total}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 30,
                width: 90,
                padding: const EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color:
                      payment.paymentStatus == 1 ? Colors.green : Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 1,
                  ),
                ),
                child: Center(
                    child: Text(
                  payment.paymentStatus == 1 ? 'Pagado' : 'Pendiente',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
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
                            // paymentID: payment.id,
                          );
                        },
                      );
                      context.read<ProfileviewProvider>().refresh(context.read<MemberSelectedProvider>().getSelectedMemberId());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
