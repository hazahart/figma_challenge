class FlightSchedule {
  final int id;
  final int flightId;
  final String departureTime;
  final String arrivalTime;

  FlightSchedule({
    required this.id,
    required this.flightId,
    required this.departureTime,
    required this.arrivalTime,
  });

  factory FlightSchedule.fromMap(Map<String, dynamic> map) {
    return FlightSchedule(
      id: map['id'],
      flightId: map['flight_id'],
      departureTime: map['departure_time'],
      arrivalTime: map['arrival_time'],
    );
  }
}