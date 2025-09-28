class Flight {
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
    this.largeAirport
  });

  // Usa Map<String, dynamic> para aceptar diferentes tipos de datos
  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      aerolinea: map['aerolinea'] ?? '',
      aeropuerto: map['aeropuerto'] ?? '',
      origen: map['origen'] ?? '',
      destino: map['destino'] ?? '',
      fecha: map['fecha'] ?? '',
      flightNumber: map['flightNumber'], // No necesita ?? '' si es nulable
      largeDestiny: map['largeDestiny'],
      description: map['description'],
      terminal: map['terminal'],
      gate: map['gate'],
      largeAirport: map['largeAirport'],
    );
  }

  // Devuelve Map<String, dynamic> para incluir todos los tipos
  Map<String, dynamic> toMap() {
    return {
      'aerolinea': aerolinea,
      'aeropuerto': aeropuerto,
      'origen': origen,
      'destino': destino,
      'fecha': fecha,
      'flightNumber': flightNumber,
      'largeDestiny': largeDestiny,
      'description': description,
      'terminal': terminal,
      'gate': gate,
      'largeAirport': largeAirport,
    };
  }
}