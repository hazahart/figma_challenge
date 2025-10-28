import 'dart:io';
import 'package:figma_challenge/screens/confirm_flight_screen.dart';
import 'package:figma_challenge/screens/search_results_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:figma_challenge/data/airport_database.dart';
import 'package:figma_challenge/utils/custom_alert.dart';
import 'package:figma_challenge/models/flights.dart';

class NewFlight extends StatefulWidget {
  final User user;

  const NewFlight({
    super.key,
    required this.user,
  });

  @override
  State<NewFlight> createState() => _NewFlightState();
}

class _NewFlightState extends State<NewFlight> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  int _selectedSearchType = 0;
  final Map<int, Widget> _searchTypes = const {
    0: Text("Number"),
    1: Text("Airport"),
    2: Text("Destination"),
  };
  final Map<int, String> _placeholders = {
    0: "e.g. LH2656",
    1: "e.g. Munich Airport",
    2: "e.g. Barcelona",
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    final searchTerm = _searchController.text.trim();

    if (searchTerm.isEmpty) {
      showCustomAlert(context, 'Empty Field', 'Please enter a search term.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = AirportDatabase.instance;
      List<Flight> results = [];

      switch (_selectedSearchType) {
        case 0:
          results = await db.getFlightTemplatesByFlightNumber(searchTerm);
          break;
        case 1:
          results = await db.getFlightTemplatesByAirport(searchTerm);
          break;
        case 2:
          results = await db.getFlightTemplatesByDestination(searchTerm);
          break;
      }

      if (mounted) {
        if (results.isEmpty) {
          showCustomAlert(context, 'Not Found', 'No flights were found with "$searchTerm".');
        } else if (results.length == 1) {
          _navigateToConfirm(results.first);
        } else {
          _navigateToResults(results);
        }
      }
    } catch (e) {
      if (mounted) {
        showCustomAlert(context, 'Error', 'An error occurred: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _navigateToConfirm(Flight flightTemplate) async {
    final bool? flightAdded = await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ConfirmFlightScreen(
          user: widget.user,
          flight: flightTemplate,
        ),
      ),
    );

    if (flightAdded == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _navigateToResults(List<Flight> results) async {
    final bool? flightAdded = await Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => SearchResultsScreen(
          user: widget.user,
          results: results,
        ),
      ),
    );

    if (flightAdded == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Close'),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_flight/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 74.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's find out how to get",
                      style: TextStyle(
                        fontSize: 19.5,
                        fontFamily: 'Montserrat-ExtraBold',
                        color: CupertinoDynamicColor.withBrightness(
                          color: Color(0xFF000000),
                          darkColor: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    const Text(
                      "To The Plane!",
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Montserrat-ExtraBold',
                        color: CupertinoColors.label,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search by:',
                      style: TextStyle(
                        color: CupertinoColors.secondaryLabel,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSegmentedControl<int>(
                        children: _searchTypes,
                        groupValue: _selectedSearchType,
                        onValueChanged: (newValue) {
                          setState(() {
                            _selectedSearchType = newValue;
                            _searchController.clear();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _searchController,
                      placeholder: _placeholders[_selectedSearchType],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      style: const TextStyle(fontSize: 19.5),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textCapitalization: _selectedSearchType == 0
                          ? TextCapitalization.characters
                          : TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: _isLoading
                          ? const Center(child: CupertinoActivityIndicator(radius: 15))
                          : CupertinoButton.filled(
                        onPressed: _performSearch,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Find the way'),
                            SizedBox(width: 5),
                            Icon(CupertinoIcons.airplane),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
