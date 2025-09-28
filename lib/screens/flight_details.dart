import 'package:figma_challenge/models/flights.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({super.key, required this.vuelo});

  final Flight vuelo;

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(0x44FFFFFF),
        border: null,
      ),
      child: ListView(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/new_flight/background.png'),
                fit: BoxFit.cover,
              ),
              color: Color(0xAA000000),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      'assets/images/airlines/${widget.vuelo.aerolinea}.png',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.vuelo.aeropuerto,
                        style: const TextStyle(
                          color: CupertinoColors.black,
                          fontSize: 24,
                          fontFamily: 'Montserrat-ExtraBold',
                        ),
                      ),
                      Text(
                        widget.vuelo.aerolinea,
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: CupertinoColors.white,
            child: Row(
              children: [
                Column(children: [Text('data')]),
              ],
            ),
          ),
          Card(child: Text('Ci')),
        ],
      ),
    );
  }
}
