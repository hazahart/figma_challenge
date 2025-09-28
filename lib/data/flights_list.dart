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
        flightNumber: "LH2656",
        largeDestiny: "Barcelona",
        description: "Franz Josef Strauss",
        terminal: 2,
        gate: "K6",
        largeAirport: "Munich International Airport",
      ),
      Flight(
        aerolinea: "virgin",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "MUC (Munich)",
        fecha: today,
        flightNumber: "VS123",
        largeDestiny: "Munich",
        description: "Josep Tarradellas",
        terminal: 1,
        gate: "A10",
        largeAirport: "Barcelona-El Prat Airport",
      ),
      Flight(
        aerolinea: "lufthansa",
        aeropuerto: "Munich Airport",
        origen: "MUC",
        destino: "BCN (Barcelona)",
        fecha: today,
        flightNumber: "LH2658",
        largeDestiny: "Barcelona",
        description: "Franz Josef Strauss",
        terminal: 2,
        gate: "K8",
        largeAirport: "Munich International Airport",
      ),
      Flight(
        aerolinea: "easyjet",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "LGW (London Gatwick)",
        fecha: today,
        flightNumber: "EZY8574",
        largeDestiny: "London Gatwick",
        description: "Josep Tarradellas",
        terminal: 2,
        gate: "C32",
        largeAirport: "Barcelona-El Prat Airport",
      ),
      Flight(
        aerolinea: "vueling",
        aeropuerto: "London Gatwick Airport",
        origen: "LGW",
        destino: "BCN (Barcelona)",
        fecha: today,
        flightNumber: "VY7821",
        largeDestiny: "Barcelona",
        description: "North Terminal",
        terminal: 1,
        gate: "55B",
        largeAirport: "London Gatwick Airport",
      ),
      Flight(
        aerolinea: "swiss",
        aeropuerto: "Grand Canaria Airport",
        origen: "LPA",
        destino: "BCN (Barcelona)",
        fecha: today,
        flightNumber: "LX2135",
        largeDestiny: "Barcelona",
        description: "Gando Airport",
        terminal: 1,
        gate: "B15",
        largeAirport: "Gran Canaria Airport",
      ),
    ];
  }
}