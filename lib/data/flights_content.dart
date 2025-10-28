import 'package:figma_challenge/data/airport_database.dart';
import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/screens/flight_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:figma_challenge/models/users_model.dart';

class FlightsContent extends StatefulWidget {
  final User user;
  const FlightsContent({super.key, required this.user});

  @override
  State<FlightsContent> createState() => FlightsContentState();
}

class FlightsContentState extends State<FlightsContent> {
  bool _isLoading = true;
  List<Flight> _vuelos = [];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    loadUserFlights();
  }

  Future<void> loadUserFlights() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }

    final db = AirportDatabase.instance;
    if (widget.user.id == null) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      return;
    }

    final userFlights = await db.getUserBookedFlights(widget.user.id!);

    if (mounted) {
      setState(() {
        _vuelos = userFlights;
        _isLoading = false;
      });
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _removeFlight(int bookingId) async {
    final db = AirportDatabase.instance;
    await db.removeUserBooking(bookingId);
    await loadUserFlights();
  }


  Widget buildFlightTile(Flight vuelo, int index) {
    if (vuelo.bookingId != null) {
      return Dismissible(
        key: Key(vuelo.bookingId.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          color: CupertinoColors.systemRed,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(CupertinoIcons.trash_fill, color: CupertinoColors.white),
        ),
        confirmDismiss: (direction) async {
          final bool? confirmed = await showCupertinoDialog<bool>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text("Confirm Deletion"),
              content: Text("Are you sure you want to delete the flight to ${vuelo.destino}?"),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text("Delete"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          );
          return confirmed ?? false;
        },
        onDismissed: (direction) {
          if (vuelo.bookingId != null) {
            _removeFlight(vuelo.bookingId!);
          }
        },
        child: _buildFlightListTile(vuelo),
      );
    }
    return _buildFlightListTile(vuelo);
  }

  Widget _buildFlightListTile(Flight vuelo) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: CupertinoColors.white,
        radius: 28,
        backgroundImage: AssetImage(
          "assets/images/airlines/${vuelo.aerolinea}.png",
        ),
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
              Text(
                vuelo.origen,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(CupertinoIcons.airplane, size: 16),
              const SizedBox(width: 5),
              Text(
                vuelo.destino,
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "${vuelo.fecha ?? 'No date'}  ·  ${vuelo.departureTime ?? 'No time'}",
            style: const TextStyle(color: CupertinoColors.secondaryLabel),
          ),
        ],
      ),
      trailing: const Icon(
        CupertinoIcons.right_chevron,
        color: CupertinoColors.tertiaryLabel,
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => FlightDetails(vuelo: vuelo)),
        ).then((flightWasRemoved) {
          if (flightWasRemoved == true) {
            loadUserFlights();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        trailing: SizedBox.shrink(),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("My Flights", style: TextStyle(fontSize: 42, fontFamily: 'Gigasans-ExtraBold', fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CupertinoActivityIndicator(radius: 15))
                  : _vuelos.isEmpty
                  ? const Center(child: Text("You have no flights added."))
                  : ListView.separated(
                padding: const EdgeInsets.only(bottom: 120, top: 16),
                itemCount: _vuelos.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 16, endIndent: 16),
                itemBuilder: (_, index) =>
                    buildFlightTile(_vuelos[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
