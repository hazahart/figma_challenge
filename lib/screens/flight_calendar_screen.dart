import 'dart:collection';
import 'package:figma_challenge/data/airport_database.dart';
import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:figma_challenge/screens/flight_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class FlightCalendarScreen extends StatefulWidget {
  final User user;
  const FlightCalendarScreen({super.key, required this.user});

  @override
  State<FlightCalendarScreen> createState() => _FlightCalendarScreenState();
}

class _FlightCalendarScreenState extends State<FlightCalendarScreen> {
  bool _isLoading = true;
  late final LinkedHashMap<DateTime, List<Flight>> _flightsByDay;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _flightsByDay = LinkedHashMap<DateTime, List<Flight>>(
      equals: isSameDay,
      hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
    );
    _loadFlightsForCalendar();
  }

  Future<void> _loadFlightsForCalendar() async {
    if (widget.user.id == null) {
      if (mounted) {
        setState(() => _isLoading = false);
        print("Error: User ID is null in FlightCalendarScreen");
      }
      return;
    }

    final db = AirportDatabase.instance;
    final bookedFlights = await db.getUserBookedFlights(widget.user.id!);
    final DateFormat formatFromDb = DateFormat("E d MMM, y", "en_US");
    final Map<DateTime, List<Flight>> events = {};

    for (final flight in bookedFlights) {
      if (flight.fecha != null) {
        try {
          DateTime flightDate = formatFromDb.parseLoose(flight.fecha!);
          DateTime normalizedDate = DateTime.utc(flightDate.year, flightDate.month, flightDate.day, 12);

          if (events[normalizedDate] == null) {
            events[normalizedDate] = [];
          }
          events[normalizedDate]!.add(flight);

        } catch (e) {
          print("Error parsing date string: '${flight.fecha}', Error: $e");
        }
      } else {
        print("Warning: Flight with bookingId ${flight.bookingId} has null fecha.");
      }
    }

    if (mounted) {
      setState(() {
        _flightsByDay.clear();
        _flightsByDay.addAll(events);
        _isLoading = false;
      });
    }
  }

  List<Flight> _getFlightsForDay(DateTime day) {
    DateTime normalizedDay = DateTime.utc(day.year, day.month, day.day, 12);
    return _flightsByDay[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = CupertinoTheme.of(context).scaffoldBackgroundColor;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Flight Calendar"),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (_isLoading)
              const Expanded(child: Center(child: CupertinoActivityIndicator())),
            if (!_isLoading)
              Material(
                color: backgroundColor,
                child: TableCalendar<Flight>(
                  locale: 'en_US',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getFlightsForDay,
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
                    weekendTextStyle: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                    outsideTextStyle: TextStyle(color: CupertinoColors.tertiaryLabel.resolveFrom(context)),
                    markerDecoration: BoxDecoration(
                      color: CupertinoTheme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: CupertinoTheme.of(context).primaryColor.withOpacity(0.25),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                        color: CupertinoTheme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    selectedDecoration: BoxDecoration(
                      color: CupertinoTheme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                        color: CupertinoTheme.of(context).primaryContrastingColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 17.0, color: CupertinoColors.label.resolveFrom(context)),
                    leftChevronIcon: Icon(CupertinoIcons.chevron_left, color: CupertinoTheme.of(context).primaryColor, size: 20),
                    rightChevronIcon: Icon(CupertinoIcons.chevron_right, color: CupertinoTheme.of(context).primaryColor, size: 20),
                    leftChevronPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    rightChevronPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    leftChevronMargin: const EdgeInsets.symmetric(horizontal: 8.0),
                    rightChevronMargin: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
                    weekendStyle: TextStyle(color: CupertinoColors.tertiaryLabel.resolveFrom(context)),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    DateTime normalizedSelectedDay = DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day, 12);
                    if (!isSameDay(_selectedDay, normalizedSelectedDay)) {
                      setState(() {
                        _selectedDay = normalizedSelectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),
            if (_selectedDay != null)
              Expanded(
                child: _buildEventList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final flights = _getFlightsForDay(_selectedDay!);

    if (flights.isEmpty) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                "No flights for this day.",
                style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))
            ),
          )
      );
    }

    return Material(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: CupertinoColors.white,
              radius: 20,
              backgroundImage: AssetImage(
                "assets/images/airlines/${flight.aerolinea}.png",
              ),
            ),
            title: Text(
              '${flight.flightNumber ?? "N/A"} (${flight.origen} -> ${flight.destino.substring(0,3)})',
              style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
            ),
            subtitle: Text(
              '${flight.departureTime ?? "--:--"} - ${flight.arrivalTime ?? "--:--"}',
              style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
            ),
            dense: true,
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (_) => FlightDetails(vuelo: flight)))
                  .then((_) => _loadFlightsForCalendar());
            },
          );
        },
      ),
    );
  }
}
