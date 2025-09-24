import 'package:figma_challenge/models/flights.dart';
import 'package:flutter/cupertino.dart';
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
      navigationBar: CupertinoNavigationBar(
        middle: Text("Vuelo ${widget.vuelo.aeropuerto}"),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // =========================================
          // aqui iran los elementos antes del tabbar
          Center(
            child: Text(
              "Detalles del vuelo: ${widget.vuelo.origen} → ${widget.vuelo.destino}\nFecha: ${widget.vuelo.fecha}",
            ),
          ),
          // =========================================
          TabBarWidget(
            currentIndex: currentIndex,
            onItemSelected: (index) {
              setState(() => currentIndex = index);
            },
            onAddPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed('/onboarding0');
            },
          ),
        ],
      ),
    );
  }
}
