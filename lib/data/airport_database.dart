import 'package:figma_challenge/models/flight_schedule.dart';
import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:figma_challenge/data/flights_list.dart';

class AirportDatabase {
  static final AirportDatabase instance = AirportDatabase._init();
  static Database? _database;

  AirportDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flights.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final schemaString = await rootBundle.loadString('lib/data/schema.sql');
    final statements = schemaString.split(';');
    for (final statement in statements) {
      final trimmedStatement = statement.trim();
      if (trimmedStatement.isNotEmpty) {
        await db.execute(trimmedStatement);
      }
    }

    final flightTemplates = FlightsList.getFlightTemplates();
    final scheduleTemplates = FlightsList.getSchedule();

    Map<String, int> flightIdMap = {};

    for (final flight in flightTemplates) {
      final id = await db.insert('Flights', flight.toMap());
      flightIdMap[flight.flightNumber!] = id;
    }

    final scheduleBatch = db.batch();
    for (final entry in scheduleTemplates.entries) {
      final flightNumber = entry.key;
      final schedules = entry.value;
      final flightId = flightIdMap[flightNumber];

      if (flightId != null) {
        for (final schedule in schedules) {
          scheduleBatch.insert('FlightSchedules', {
            'flight_id': flightId,
            'departure_time': schedule.departure,
            'arrival_time': schedule.arrival,
          });
        }
      }
    }
    await scheduleBatch.commit(noResult: true);
  }

  Future<User> createUser(User user) async {
    final db = await instance.database;
    final id = await db.insert('Users', user.toMap());
    return user.copyWith(id: id);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await instance.database;
    final maps = await db.query(
      'Users',
      columns: ['id', 'nombre', 'apellidos', 'email', 'password', 'sexo', 'fecha_nacimiento'],
      where: 'email = ?',
      whereArgs: [email],
    );
    return maps.isNotEmpty ? User.fromMap(maps.first) : null;
  }

  Future<User?> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'Users',
      columns: ['id', 'nombre', 'apellidos', 'email', 'password', 'sexo', 'fecha_nacimiento'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? User.fromMap(maps.first) : null;
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db.update(
      'Users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Flight>> getFlightTemplatesByFlightNumber(String flightNumber) async {
    final db = await instance.database;
    final maps = await db.query(
      'Flights',
      where: 'flight_number = ?',
      whereArgs: [flightNumber.toUpperCase()],
    );
    return maps.map((map) => Flight.fromMap(map)).toList();
  }

  Future<List<Flight>> getFlightTemplatesByAirport(String airportName) async {
    final db = await instance.database;
    final maps = await db.query(
      'Flights',
      where: 'aeropuerto LIKE ?',
      whereArgs: ['%$airportName%'],
    );
    return maps.map((map) => Flight.fromMap(map)).toList();
  }

  Future<List<Flight>> getFlightTemplatesByDestination(String destinationName) async {
    final db = await instance.database;
    final maps = await db.query(
      'Flights',
      where: 'large_destiny LIKE ?',
      whereArgs: ['%$destinationName%'],
    );
    return maps.map((map) => Flight.fromMap(map)).toList();
  }

  Future<List<FlightSchedule>> getSchedulesForFlight(int flightId) async {
    final db = await instance.database;
    final maps = await db.query(
      'FlightSchedules',
      where: 'flight_id = ?',
      whereArgs: [flightId],
    );
    return maps.map((map) => FlightSchedule.fromMap(map)).toList();
  }

  Future<bool> checkIfBookingExists({
    required int userId,
    required int scheduleId,
    required String flightDate,
  }) async {
    final db = await instance.database;
    final maps = await db.query(
      'UserBookings',
      where: 'user_id = ? AND schedule_id = ? AND flight_date = ?',
      whereArgs: [userId, scheduleId, flightDate],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  Future<void> addUserBooking({
    required int userId,
    required int scheduleId,
    required String flightDate,
  }) async {
    final db = await instance.database;
    await db.insert(
      'UserBookings',
      {
        'user_id': userId,
        'schedule_id': scheduleId,
        'flight_date': flightDate,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeUserBooking(int bookingId) async {
    final db = await instance.database;
    await db.delete(
      'UserBookings',
      where: 'id = ?',
      whereArgs: [bookingId],
    );
  }

  Future<List<Flight>> getUserBookedFlights(int userId) async {
    final db = await instance.database;

    final result = await db.rawQuery('''
      SELECT
        F.*,
        S.id as scheduleId,
        S.departure_time,
        S.arrival_time,
        B.id as bookingId,
        B.flight_date as fecha
      FROM Flights F
      JOIN FlightSchedules S ON F.id = S.flight_id
      JOIN UserBookings B ON S.id = B.schedule_id
      WHERE B.user_id = ?
      ORDER BY B.flight_date, S.departure_time
    ''', [userId]);

    return result.map((map) => Flight.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}