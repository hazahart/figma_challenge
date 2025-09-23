import 'package:figma_challenge/models/flights.dart';
import 'package:intl/intl.dart';

class FlightsList {
  static List<Flight> getFlights() {
    final DateTime now = DateTime.now();
    final DateFormat fechaFormateada = DateFormat("E d MMM, y", "es_MX");
    final String today = fechaFormateada.format(now);

    return [
      Flight(
        aerolinea: "lufthansa",
        aeropuerto: "Munich Airport",
        origen: "MUC",
        destino: "BCN (Barcelona)",
        fecha: today,
      ),
      Flight(
        aerolinea: "virgin",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "MUC (Munich)",
        fecha: today,
      ),
      Flight(
        aerolinea: "lufthansa",
        aeropuerto: "Munich Airport",
        origen: "MUC",
        destino: "BCN (Barcelona)",
        fecha: today,
      ),
      Flight(
        aerolinea: "easyjet",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "LGW (London Gatwick)",
        fecha: today,
      ),
      Flight(
        aerolinea: "vueling",
        aeropuerto: "London Gatwick Airport",
        origen: "LGW",
        destino: "BCN (Barcelona)",
        fecha: today,
      ),
      Flight(
        aerolinea: "swiss",
        aeropuerto: "Grand Canaria Airport",
        origen: "LPA",
        destino: "BCN (Barcelona)",
        fecha: today,
      ),
    ];
  }
}
