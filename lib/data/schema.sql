-- Eliminar todas las tablas antes de la carga
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS UserFlights;

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
    aerolinea TEXT NOT NULL,
    aeropuerto TEXT NOT NULL,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    fecha TEXT NOT NULL,
    flight_number TEXT,
    large_destiny TEXT,
    description TEXT,
    terminal INTEGER,
    gate TEXT,
    large_airport TEXT
);

CREATE TABLE UserFlights (
    user_id INTEGER NOT NULL,
    flight_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, flight_id),
    FOREIGN KEY (user_id) REFERENCES Users (id) ON DELETE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flights (id) ON DELETE CASCADE
);