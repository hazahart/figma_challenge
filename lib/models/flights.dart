class Flight {
  final String aerolinea;
  final String aeropuerto;
  final String origen;
  final String destino;
  final String fecha;

  Flight({
    required this.aerolinea,
    required this.aeropuerto,
    required this.origen,
    required this.destino,
    required this.fecha,
  });

  factory Flight.fromMap(Map<String, String> map) {
    return Flight(
      aerolinea: map["aerolinea"] ?? "",
      aeropuerto: map["aeropuerto"] ?? "",
      origen: map["origen"] ?? "",
      destino: map["destino"] ?? "",
      fecha: map["fecha"] ?? "",
    );
  }

  Map<String, String> toMap() {
    return {
      "aerolinea": aerolinea,
      "aeropuerto": aeropuerto,
      "origen": origen,
      "destino": destino,
      "fecha": fecha,
    };
  }
}
