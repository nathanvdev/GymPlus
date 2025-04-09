import 'package:flutter/material.dart';
import 'package:frontend/config/theme/app_theme.dart';
import 'package:frontend/providers/transaction_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StatsPaymentCard extends StatelessWidget {
  final String value;
  final String subtitle;
  final String value1;
  final String subtitle1;
  const StatsPaymentCard({
    super.key,
    required this.value,
    required this.subtitle,
    required this.value1,
    required this.subtitle1,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 7),
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
            ],
          )
        ],
      ),
    );
  }
}

class StatsCash extends StatefulWidget {
  const StatsCash({super.key});

  @override
  State<StatsCash> createState() => _StatsCashState();
}

class _StatsCashState extends State<StatsCash> {
  final String value = '';
  final String subtitle = '';
  final String value1 = '';
  final String subtitle1 = '';
  final String value2 = '';
  final String subtitle2 = '';
  bool showSensitiveDetails = false;

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();


    return Container(
      height: 135,
      width: MediaQuery.of(context).size.width * 0.50,
      margin: const EdgeInsets.all(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Saldo Disponible",
                      style: GoogleFonts.pridi(
                        fontSize: 25,
                        color: const Color.fromARGB(255, 115, 115, 115),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(showSensitiveDetails
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showSensitiveDetails = !showSensitiveDetails;
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10,),
                child: Text(
                  showSensitiveDetails
                    ? transactionProvider.transactionList.isNotEmpty
                      ? "Q. ${transactionProvider.transactionList.first.disponible}"
                      : "Q. 0.00"
                  : "Q. *********",
                  style: GoogleFonts.pridi(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 154, 154, 154)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Saldo En Reserva",
                  style: GoogleFonts.pridi(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  showSensitiveDetails
                    ? transactionProvider.transactionList.isNotEmpty
                      ? "Q. ${transactionProvider.transactionList.first.reserva}"
                      : "Q. 0.00"
                  : "Q. *********",
                  style: GoogleFonts.pridi(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 154, 154, 154)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Saldo Total",
                  style: GoogleFonts.pridi(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  showSensitiveDetails
                    ? transactionProvider.transactionList.isNotEmpty
                      ? "Q. ${transactionProvider.transactionList.first.total}"
                      : "Q. 0.00"
                  : "Q. *********",
                  style: GoogleFonts.pridi(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 154, 154, 154)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

