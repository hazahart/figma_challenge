import 'package:figma_challenge/models/flights.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        border: null,
        backgroundColor: CupertinoColors.transparent,
        automaticBackgroundVisibility: false,
        enableBackgroundFilterBlur: false,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          child: Icon(
            CupertinoIcons.chevron_left,
            color: CupertinoColors.white,
            fontWeight: FontWeight.bold,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/airports/${widget.vuelo.origen.toLowerCase()}.png',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.65,
                  ),
                  color: const Color(0xFF000000),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: const Color(0xFFFFFFFF),
                        backgroundImage: AssetImage(
                          'assets/images/airlines/${widget.vuelo.aerolinea}.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.vuelo.aeropuerto,
                              softWrap: true,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 32,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.vuelo.aerolinea.isNotEmpty
                                  ? widget.vuelo.aerolinea[0].toUpperCase() +
                                        widget.vuelo.aerolinea
                                            .substring(1)
                                            .toLowerCase()
                                  : "",
                              softWrap: true,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 26,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: CupertinoColors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 42,
                    bottom: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.vuelo.origen,
                              style: TextStyle(
                                fontFamily: 'Rebelton-Bold',
                                fontSize: 48,
                              ),
                            ),
                            Text(
                              "10:55",
                              style: TextStyle(
                                fontFamily: 'SF-Pro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.vuelo.fecha,
                              style: TextStyle(
                                fontFamily: 'SF-Pro',
                                color: Color(0xFF8A8A8E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          CupertinoIcons.airplane,
                          size: 48,
                          color: Color(0xFF000000),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.vuelo.destino.substring(0, 3),
                              style: TextStyle(
                                fontFamily: 'Rebelton-Bold',
                                fontSize: 48,
                              ),
                            ),
                            Text(
                              "10:55",
                              style: TextStyle(
                                fontFamily: 'SF-Pro',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.vuelo.fecha,
                              style: TextStyle(
                                fontFamily: 'SF-Pro',
                                color: Color(0xFF8A8A8E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Card(
                  elevation: 0,
                  color: const Color(0xFFF2F2F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          'Flight Number:',
                          Row(
                            children: [
                              Text(
                                "${widget.vuelo.flightNumber ?? 'NA'} (${widget.vuelo.largeDestiny ?? 'NA'})",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildInfoRow(
                          'Airline:',
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/airlines/${widget.vuelo.aerolinea}.png",
                                height: 24,
                              ),
                              SizedBox(width: 5),
                              Text(
                                widget.vuelo.aerolinea[0].toUpperCase() +
                                        widget.vuelo.aerolinea.substring(1) ??
                                    "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Helvetica-Bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Departure Airport:',
                                style: TextStyle(
                                  color: CupertinoColors.secondaryLabel,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.vuelo.largeAirport ?? "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: CupertinoColors.label,
                                ),
                              ),
                              Text(
                                widget.vuelo.description ?? "N/A",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: CupertinoColors.label,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSmallInfoCard(
                                'Terminal:',
                                "${widget.vuelo.terminal ?? 'N/A'}",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSmallInfoCard(
                                'Gate:',
                                widget.vuelo.gate ?? 'N/A',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Necesitarás los siguientes documentos:"),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          children: [
                            _buildIconText(
                              'passport',
                              'Pasaporte o identificación',
                            ),
                            _buildIconText("qr_code", "Pase de abordar"),
                            _buildIconText(
                              "mask",
                              "Pasaporte COVID-19 o prueba PCR negativa",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
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

  Widget _buildInfoRow(String label, Widget valueWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        valueWidget,
      ],
    );
  }

  Widget _buildSmallInfoCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 48,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
              color: CupertinoColors.label,
            ),
          ),
        ],
      ),
    );
  }

  _buildIconText(String asset, String text) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/$asset.svg', width: 36),
        Text(text),
      ],
    );
  }
}
