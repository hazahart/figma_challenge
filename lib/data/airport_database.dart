import 'package:figma_challenge/models/flights.dart';
import 'package:figma_challenge/models/users_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final schemaString = await rootBundle.loadString('lib/data/schema.sql');
    
    final statements = schemaString.split(';');

    final batch = db.batch();
    for (final statement in statements) {
      final trimmedStatement = statement.trim();
      if (trimmedStatement.isNotEmpty) {
        batch.execute(trimmedStatement);
      }
    }
    
    await batch.commit(noResult: true);
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

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<User?> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'Users',
      columns: ['id', 'nombre', 'apellidos', 'email', 'password', 'sexo', 'fecha_nacimiento'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
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

  Future<Flight> createFlight(Flight flight) async {
    final db = await instance.database;
    final id = await db.insert('Flights', flight.toMap());
    return flight.copyWith(id: id);
  }

  // Read a single flight by id
  Future<Flight?> getFlightById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'Flights',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Flight.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> addUserFlight(int userId, int flightId) async {
    final db = await instance.database;
    await db.insert(
      'UserFlights',
      {'user_id': userId, 'flight_id': flightId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeUserFlight(int userId, int flightId) async {
    final db = await instance.database;
    await db.delete(
      'UserFlights',
      where: 'user_id = ? AND flight_id = ?',
      whereArgs: [userId, flightId],
    );
  }

  Future<List<Flight>> getUserFlights(int userId) async {
    final db = await instance.database;
    
    final result = await db.rawQuery('''
      SELECT F.* FROM Flights F
      JOIN UserFlights UF ON F.id = UF.flight_id
      WHERE UF.user_id = ?
    ''', [userId]);

    return result.map((map) => Flight.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

