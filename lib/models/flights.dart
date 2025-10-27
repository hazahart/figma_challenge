class Flight {
  final int? id;
  final String aerolinea;
  final String aeropuerto;
  final String origen;
  final String destino;
  final String? flightNumber;
  final String? largeDestiny;
  final String? description;
  final int? terminal;
  final String? gate;
  final String? largeAirport;
  final int? scheduleId;
  final String? departureTime;
  final String? arrivalTime;
  final int? bookingId;
  final String? fecha;

  Flight({
    this.id,
    required this.aerolinea,
    required this.aeropuerto,
    required this.origen,
    required this.destino,
    this.flightNumber,
    this.largeDestiny,
    this.description,
    this.terminal,
    this.gate,
    this.largeAirport,
    this.scheduleId,
    this.departureTime,
    this.arrivalTime,
    this.bookingId,
    this.fecha,
  });

  Flight copyWith({
    int? id,
    String? aerolinea,
    String? aeropuerto,
    String? origen,
    String? destino,
    String? flightNumber,
    String? largeDestiny,
    String? description,
    int? terminal,
    String? gate,
    String? largeAirport,
    int? scheduleId,
    String? departureTime,
    String? arrivalTime,
    int? bookingId,
    String? fecha,
  }) {
    return Flight(
      id: id ?? this.id,
      aerolinea: aerolinea ?? this.aerolinea,
      aeropuerto: aeropuerto ?? this.aeropuerto,
      origen: origen ?? this.origen,
      destino: destino ?? this.destino,
      flightNumber: flightNumber ?? this.flightNumber,
      largeDestiny: largeDestiny ?? this.largeDestiny,
      description: description ?? this.description,
      terminal: terminal ?? this.terminal,
      gate: gate ?? this.gate,
      largeAirport: largeAirport ?? this.largeAirport,
      scheduleId: scheduleId ?? this.scheduleId,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      bookingId: bookingId ?? this.bookingId,
      fecha: fecha ?? this.fecha,
    );
  }

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'] as int?,
      aerolinea: map['aerolinea'] ?? '',
      aeropuerto: map['aeropuerto'] ?? '',
      origen: map['origen'] ?? '',
      destino: map['destino'] ?? '',
      flightNumber: map['flight_number'],
      largeDestiny: map['large_destiny'],
      description: map['description'],
      terminal: map['terminal'],
      gate: map['gate'],
      largeAirport: map['large_airport'],
      scheduleId: map['scheduleId'],
      departureTime: map['departure_time'],
      arrivalTime: map['arrival_time'],
      bookingId: map['bookingId'],
      fecha: map['fecha'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aerolinea': aerolinea,
      'aeropuerto': aeropuerto,
      'origen': origen,
      'destino': destino,
      'flight_number': flightNumber,
      'large_destiny': largeDestiny,
      'description': description,
      'terminal': terminal,
      'gate': gate,
      'large_airport': largeAirport,
    };
  }
}