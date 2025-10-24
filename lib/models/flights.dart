class Flight {
  final int? id;
  final String aerolinea;
  final String aeropuerto;
  final String origen;
  final String destino;
  final String fecha;
  final String? flightNumber;
  final String? largeDestiny;
  final String? description;
  final int? terminal;
  final String? gate;
  final String? largeAirport;

  Flight({
    this.id,
    required this.aerolinea,
    required this.aeropuerto,
    required this.origen,
    required this.destino,
    required this.fecha,
    this.flightNumber,
    this.largeDestiny,
    this.description,
    this.terminal,
    this.gate,
    this.largeAirport,
  });

  Flight copyWith({
    int? id,
    String? aerolinea,
    String? aeropuerto,
    String? origen,
    String? destino,
    String? fecha,
    String? flightNumber,
    String? largeDestiny,
    String? description,
    int? terminal,
    String? gate,
    String? largeAirport,
  }) {
    return Flight(
      id: id ?? this.id,
      aerolinea: aerolinea ?? this.aerolinea,
      aeropuerto: aeropuerto ?? this.aeropuerto,
      origen: origen ?? this.origen,
      destino: destino ?? this.destino,
      fecha: fecha ?? this.fecha,
      flightNumber: flightNumber ?? this.flightNumber,
      largeDestiny: largeDestiny ?? this.largeDestiny,
      description: description ?? this.description,
      terminal: terminal ?? this.terminal,
      gate: gate ?? this.gate,
      largeAirport: largeAirport ?? this.largeAirport,
    );
  }

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      id: map['id'] as int?,
      aerolinea: map['aerolinea'] ?? '',
      aeropuerto: map['aeropuerto'] ?? '',
      origen: map['origen'] ?? '',
      destino: map['destino'] ?? '',
      fecha: map['fecha'] ?? '',
      flightNumber: map['flight_number'],
      largeDestiny: map['large_destiny'],
      description: map['description'],
      terminal: map['terminal'],
      gate: map['gate'],
      largeAirport: map['large_airport'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aerolinea': aerolinea,
      'aeropuerto': aeropuerto,
      'origen': origen,
      'destino': destino,
      'fecha': fecha,
      'flight_number': flightNumber,
      'large_destiny': largeDestiny,
      'description': description,
      'terminal': terminal,
      'gate': gate,
      'large_airport': largeAirport,
    };
  }
}