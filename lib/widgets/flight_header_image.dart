import 'package:flutter/cupertino.dart';

class FlightHeaderImage extends StatefulWidget {
  final String airportImagePath;
  final String airlineLogoPath;
  final String airportName;
  final String airlineName;

  const FlightHeaderImage({
    super.key,
    required this.airportImagePath,
    required this.airlineLogoPath,
    required this.airportName,
    required this.airlineName,
  });

  @override
  State<FlightHeaderImage> createState() => _FlightHeaderImageState();
}

class _FlightHeaderImageState extends State<FlightHeaderImage> {
  @override
  Widget build(BuildContext context) {
    // Estilo de texto reutilizable con sombra para mejor legibilidad
    const textStyleWithShadow = TextStyle(
      color: CupertinoColors.white,
      shadows: [
        Shadow(
          blurRadius: 8.0,
          color: Color.fromARGB(150, 0, 0, 0),
          offset: Offset(2.0, 2.0),
        ),
      ],
    );

    return Stack(
      children: [
        // 1. La imagen de fondo del aeropuerto
        Container(
          height: 300, // Altura del encabezado
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.airportImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 2. Degradado oscuro para legibilidad de la barra de estado
        Container(
          height: 120, // Solo en la parte superior
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CupertinoColors.black.withOpacity(0.5),
                CupertinoColors.transparent,
              ],
            ),
          ),
        ),

        // 3. Contenido superpuesto (logo y texto)
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo de la aerolínea
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.white, // Fondo blanco por si la imagen es transparente
                  image: DecorationImage(
                    image: AssetImage(widget.airlineLogoPath),
                  ),
                  border: Border.all(color: CupertinoColors.white, width: 2),
                ),
              ),
              const SizedBox(width: 16),

              // Nombres del aeropuerto y aerolínea
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.airportName,
                    style: textStyleWithShadow.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-ExtraBold'
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.airlineName,
                    style: textStyleWithShadow.copyWith(
                      fontSize: 18,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}