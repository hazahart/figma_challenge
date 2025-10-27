import 'package:figma_challenge/data/airport_database.dart';
import 'package:figma_challenge/models/flight_schedule.dart';
import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmFlightScreen extends StatefulWidget {
  final User user;
  final Flight flight;

  const ConfirmFlightScreen({
    super.key,
    required this.user,
    required this.flight,
  });

  @override
  State<ConfirmFlightScreen> createState() => _ConfirmFlightScreenState();
}

class _ConfirmFlightScreenState extends State<ConfirmFlightScreen> {
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  List<FlightSchedule> _schedules = [];
  int? _selectedScheduleId;
  String _selectedTimeText = "Selecciona un horario";
  bool _isDataLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final db = AirportDatabase.instance;
    if (widget.flight.id == null) {
      if (mounted) {
        setState(() => _isDataLoading = false);
        _showManualAlert(title: "Error", message: "ID de plantilla de vuelo inválido.", popOnOk: false);
      }
      return;
    }
    final schedules = await db.getSchedulesForFlight(widget.flight.id!);
    if (mounted) {
      setState(() {
        _schedules = schedules;
        if (schedules.length == 1) {
          _selectedScheduleId = schedules.first.id;
          _selectedTimeText = "${schedules.first.departureTime} - ${schedules.first.arrivalTime}";
        }
        _isDataLoading = false;
      });
    }
  }

  Future<void> _addUserBooking() async {
    if (_selectedScheduleId == null) {
      _showManualAlert(title: 'Horario no seleccionado', message: 'Por favor, selecciona un horario para tu vuelo.', popOnOk: false);
      return;
    }
    if (widget.user.id == null || widget.flight.id == null) {
      _showManualAlert(title: 'Error de Datos', message: 'El ID de usuario o de vuelo es nulo.', popOnOk: false);
      return;
    }

    setState(() => _isLoading = true);

    final db = AirportDatabase.instance;
    final String formattedDate = DateFormat("E d MMM, y", "es_MX").format(_selectedDate);

    try {
      bool alreadyExists = await db.checkIfBookingExists(
        userId: widget.user.id!,
        scheduleId: _selectedScheduleId!,
        flightDate: formattedDate,
      );

      if (alreadyExists) {
        if (mounted) {
          setState(() => _isLoading = false);
          _showManualAlert(
            title: 'Vuelo Duplicado',
            message: 'Este vuelo ya se encuentra en tu lista para la fecha y hora seleccionadas.',
            popOnOk: false,
          );
        }
        return;
      }

      await db.addUserBooking(
        userId: widget.user.id!,
        scheduleId: _selectedScheduleId!,
        flightDate: formattedDate,
      );

      if (mounted) {
        setState(() => _isLoading = false);
        _showManualAlert(
          title: '¡Vuelo añadido!',
          message: 'El vuelo ${widget.flight.flightNumber} para el $formattedDate ha sido añadido.',
          popOnOk: true,
        );
      }

    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showManualAlert(
          title: 'Error',
          message: 'Ocurrió un error al guardar: ${e.toString()}',
          popOnOk: false,
        );
      }
    }
  }

  void _showManualAlert({required String title, required String message, required bool popOnOk}) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (popOnOk) {
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                color: CupertinoColors.secondarySystemBackground.resolveFrom(
                  context,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: const Text('Listo'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate,
                  minimumDate: DateTime.now().subtract(const Duration(days: 1)),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTimePicker(BuildContext context) {
    if (_schedules.isEmpty) return;

    int selectedIndex = _schedules.indexWhere((s) => s.id == _selectedScheduleId);
    if (selectedIndex < 0) selectedIndex = 0;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              Container(
                color: CupertinoColors.secondarySystemBackground.resolveFrom(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      child: const Text('Listo'),
                      onPressed: () {
                        if (selectedIndex >= 0 && selectedIndex < _schedules.length) {
                          final selectedSchedule = _schedules[selectedIndex];
                          setState(() {
                            _selectedScheduleId = selectedSchedule.id;
                            _selectedTimeText = "${selectedSchedule.departureTime} - ${selectedSchedule.arrivalTime}";
                          });
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                  onSelectedItemChanged: (int index) {
                    selectedIndex = index;
                  },
                  children: _schedules.map((schedule) {
                    return Center(
                      child: Text("${schedule.departureTime} - ${schedule.arrivalTime}"),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vuelo = widget.flight;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Confirm Flight"),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              vuelo.origen,
                              style: const TextStyle(
                                fontFamily: 'Rebelton-Bold',
                                fontSize: 48,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                              vuelo.destino.substring(0, 3),
                              style: const TextStyle(
                                fontFamily: 'Rebelton-Bold',
                                fontSize: 48,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
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
                                  "${vuelo.flightNumber ?? 'NA'} (${vuelo.largeDestiny ?? 'NA'})",
                                  style: const TextStyle(
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
                                  "assets/images/airlines/${vuelo.aerolinea}.png",
                                  height: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  vuelo.aerolinea.isNotEmpty
                                      ? vuelo.aerolinea[0].toUpperCase() +
                                      (vuelo.aerolinea.length > 1 ? vuelo.aerolinea.substring(1) : "") ??
                                      "N/A"
                                      : "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Helvetica-Bold',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
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
                                const SizedBox(height: 4),
                                Text(
                                  vuelo.largeAirport ?? "N/A",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: CupertinoColors.label,
                                  ),
                                ),
                                Text(
                                  vuelo.description ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: CupertinoColors.secondaryLabel,
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
                                  "${vuelo.terminal ?? 'N/A'}",
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSmallInfoCard(
                                  'Gate:',
                                  vuelo.gate ?? 'N/A',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Select Date & Time",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showDatePicker(context),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.calendar),
                        const SizedBox(width: 8),
                        const Text(
                          "Fecha: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          DateFormat("E d MMM, y", "es_MX").format(_selectedDate),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.systemBlue
                          ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showTimePicker(context),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.clock),
                        const SizedBox(width: 8),
                        const Text(
                          "Horario: ",
                          style: TextStyle(fontSize: 16),
                        ),
                        _isDataLoading
                            ? const CupertinoActivityIndicator(radius: 10)
                            : Text(
                          _selectedTimeText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _selectedScheduleId == null
                                ? CupertinoColors.systemRed
                                : CupertinoColors.systemBlue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      color: CupertinoColors.systemGrey5,
                      child: const Text(
                        "Back",
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : CupertinoButton.filled(
                      child: const Text("Next"),
                      onPressed: _addUserBooking,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
}