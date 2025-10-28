import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'confirm_flight_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final User user;
  final List<Flight> results;

  const SearchResultsScreen({
    super.key,
    required this.user,
    required this.results,
  });

  Future<void> _navigateToConfirm(BuildContext context, Flight flightTemplate) async {
    final bool? flightAdded = await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ConfirmFlightScreen(
          user: user,
          flight: flightTemplate,
        ),
      ),
    );

    if (flightAdded == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Search Results"),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final vuelo = results[index];

            return CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              alignment: Alignment.centerLeft,
              onPressed: () {
                _navigateToConfirm(context, vuelo);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CupertinoColors.separator,
                      width: 0.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        backgroundColor: CupertinoColors.white,
                        radius: 28,
                        backgroundImage: AssetImage(
                          "assets/images/airlines/${vuelo.aerolinea}.png",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vuelo.flightNumber ?? "N/A",
                            style: const TextStyle(
                              fontFamily: "Montserrat-ExtraBold",
                              fontSize: 17,
                              color: CupertinoColors.label,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${vuelo.aeropuerto} (${vuelo.largeAirport ?? 'N/A'})",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              color: CupertinoColors.secondaryLabel,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                vuelo.origen,
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: CupertinoColors.secondaryLabel,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(CupertinoIcons.airplane, size: 16, color: CupertinoColors.secondaryLabel),
                              const SizedBox(width: 5),
                              Text(
                                vuelo.destino.split(' ')[0],
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: CupertinoColors.secondaryLabel,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        CupertinoIcons.right_chevron,
                        color: CupertinoColors.tertiaryLabel,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
