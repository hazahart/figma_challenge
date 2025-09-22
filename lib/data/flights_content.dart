import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightsContent extends StatelessWidget {
  const FlightsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final DateFormat fechaFormateada = DateFormat("E d MMM, y", "es_MX");

    final String today = fechaFormateada.format(now);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("My Flights"),
        trailing: CupertinoButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          child: const Text("Edit"),
        ),
      ),
      child: ListView.separated(
        itemCount: 16,
        separatorBuilder: (context, index) {
          return const Divider(height: 1, indent: 16, endIndent: 16);
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text("Vuelo #${index + 1}"),
                    content: const Text("Has seleccionado este vuelo. ¿Qué te gustaría hacer?"),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "assets/images/airlines/aeromexico.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aeropuerto Internacional de la Ciudad de México",
                            style: TextStyle(fontFamily: "Montserrat-ExtraBold"),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text("CDMX"),
                              SizedBox(width: 5),
                              Icon(CupertinoIcons.airplane),
                              SizedBox(width: 5),
                              Text("BCN (Barcelona)"),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            today,
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.right_chevron,
                      color: CupertinoColors.tertiaryLabel,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
