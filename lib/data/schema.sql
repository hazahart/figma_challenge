DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS FlightSchedules;
DROP TABLE IF EXISTS UserFlights;
DROP TABLE IF EXISTS UserBookings;

CREATE TABLE Users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    sexo TEXT,
    fecha_nacimiento TEXT
);

CREATE TABLE Flights (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    flight_number TEXT NOT NULL UNIQUE,
    aerolinea TEXT NOT NULL,
    aeropuerto TEXT NOT NULL,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    large_destiny TEXT,
    description TEXT,
    terminal INTEGER,
    gate TEXT,
    large_airport TEXT
);

CREATE TABLE FlightSchedules (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    flight_id INTEGER NOT NULL,
    departure_time TEXT NOT NULL,
    arrival_time TEXT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights (id) ON DELETE CASCADE
);

CREATE TABLE UserBookings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    schedule_id INTEGER NOT NULL,
    flight_date TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES FlightSchedules (id) ON DELETE CASCADE
);