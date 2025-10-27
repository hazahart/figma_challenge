import 'package:figma_challenge/models/flights.dart';

class ScheduleTemplate {
  final String departure;
  final String arrival;
  ScheduleTemplate(this.departure, this.arrival);
}

class FlightsList {
  static List<Flight> getFlightTemplates() {
    return [
      Flight(
        aerolinea: "lufthansa",
        aeropuerto: "Munich Airport",
        origen: "MUC",
        destino: "BCN (Barcelona)",
        flightNumber: "LH2656",
        largeDestiny: "Barcelona",
        description: "Franz Josef Strauss",
        terminal: 2,
        gate: "K6",
        largeAirport: "Munich International Airport",
      ),
      Flight(
        aerolinea: "lufthansa",
        aeropuerto: "Munich Airport",
        origen: "MUC",
        destino: "BCN (Barcelona)",
        flightNumber: "LH2658",
        largeDestiny: "Barcelona",
        description: "Franz Josef Strauss",
        terminal: 2,
        gate: "K8",
        largeAirport: "Munich International Airport",
      ),
      Flight(
        aerolinea: "virgin",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "MUC (Munich)",
        flightNumber: "VS123",
        largeDestiny: "Munich",
        description: "Josep Tarradellas",
        terminal: 1,
        gate: "A10",
        largeAirport: "Barcelona-El Prat Airport",
      ),
      Flight(
        aerolinea: "easyjet",
        aeropuerto: "Barcelona Airport",
        origen: "BCN",
        destino: "LGW (London Gatwick)",
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
        flightNumber: "LX2135",
        largeDestiny: "Barcelona",
        description: "Gando Airport",
        terminal: 1,
        gate: "B15",
        largeAirport: "Gran Canaria Airport",
      ),
    ];
  }

  static Map<String, List<ScheduleTemplate>> getSchedule() {
    return {
      "LH2656": [
        ScheduleTemplate("10:55", "12:55"),
        ScheduleTemplate("18:30", "20:30"),
      ],
      "LH2658": [
        ScheduleTemplate("06:15", "08:15"),
      ],
      "VS123": [
        ScheduleTemplate("14:00", "16:05"),
      ],
      "EZY8574": [
        ScheduleTemplate("09:45", "11:20"),
        ScheduleTemplate("20:00", "21:35"),
      ],
      "VY7821": [
        ScheduleTemplate("12:00", "15:10"),
      ],
      "LX2135": [
        ScheduleTemplate("17:30", "20:50"),
      ],
    };
  }
}