import 'package:figma_challenge/models/flights.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/tabbar.dart';

class FlightDetails extends StatefulWidget {
  const FlightDetails({super.key, required this.vuelo});

  final Flight vuelo;

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // backgroundColor: Color(0x44FFFFFF),
        border: null,
        backgroundColor: CupertinoColors.transparent,
        automaticBackgroundVisibility: false,
        enableBackgroundFilterBlur: false,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/airports/${widget.vuelo.origen.toLowerCase()}.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.65,
                  ),
                  color: const Color(0xFF000000),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: const Color(0xFFFFFFFF),
                        backgroundImage: AssetImage(
                          'assets/images/airlines/${widget.vuelo.aerolinea}.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.vuelo.aeropuerto,
                              softWrap: true,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 32,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.vuelo.aerolinea.isNotEmpty
                                  ? widget.vuelo.aerolinea[0].toUpperCase() +
                                  widget.vuelo.aerolinea
                                      .substring(1)
                                      .toLowerCase()
                                  : "",
                              softWrap: true,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 26,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.white,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(children: [Text('data')]),
                    ],
                  ),
                ),
              ),
              const Card(child: Text('Ci')),
              const SizedBox(height: 120),
            ],
          ),
          TabBarWidget(
            currentIndex: currentIndex,
            onItemSelected: (index) {
              setState(() => currentIndex = index);
            },
            onAddPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed('/onboarding0');
            },
          ),
        ],
      ),
    );
  }
}
