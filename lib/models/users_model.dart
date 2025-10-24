class User {
  final int? id;
  final String nombre;
  final String apellidos;
  final String email;
  final String password;
  final String? sexo;
  final String? fechaNacimiento;

  const User({
    this.id,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.password,
    this.sexo,
    this.fechaNacimiento,
  });

  User copyWith({
    int? id,
    String? nombre,
    String? apellidos,
    String? email,
    String? password,
    String? sexo,
    String? fechaNacimiento,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      email: email ?? this.email,
      password: password ?? this.password,
      sexo: sexo ?? this.sexo,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      apellidos: map['apellidos'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      sexo: map['sexo'] as String?,
      fechaNacimiento: map['fecha_nacimiento'] as String?,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'email': email,
      'password': password,
      'sexo': sexo,
      'fecha_nacimiento': fechaNacimiento,
    };
  }
}
