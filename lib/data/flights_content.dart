import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/screens/flight_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'flights_list.dart';

class FlightsContent extends StatelessWidget {
  const FlightsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vuelos = FlightsList.getFlights();

    Widget buildFlightTile(Flight vuelo, int index) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: CupertinoColors.white,
          radius: 28,
          backgroundImage: AssetImage("assets/images/airlines/${vuelo.aerolinea}.png"),
        ),
        title: Text(
          vuelo.aeropuerto,
          style: const TextStyle(fontFamily: "Montserrat-ExtraBold"),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(vuelo.origen, style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.bold)),
                const SizedBox(width: 5),
                const Icon(CupertinoIcons.airplane, size: 16),
                const SizedBox(width: 5),
                Text(vuelo.destino, style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.bold)),
              ],
            ),
            Text(
              vuelo.fecha,
              style: const TextStyle(color: CupertinoColors.secondaryLabel),
            ),
          ],
        ),
        trailing: const Icon(CupertinoIcons.right_chevron,
            color: CupertinoColors.tertiaryLabel),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => FlightDetails(vuelo: vuelo),
              ),
            );
          },
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("My Flights"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: const Text("Edit"),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 120, top: 80),
        itemCount: vuelos.length,
        separatorBuilder: (_, __) =>
        const Divider(height: 1, indent: 16, endIndent: 16),
        itemBuilder: (_, index) => buildFlightTile(vuelos[index], index),
      ),
    );
  }
}
