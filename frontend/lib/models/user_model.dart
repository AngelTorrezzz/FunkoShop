class UserModel {
  int? id;
  String nombreUsuario;
  String? correo;
  String contrasena;

  UserModel({
    this.id,
    required this.nombreUsuario,
    this.correo,
    required this.contrasena,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombreUsuario: json['nombreUsuario'],
      correo: json['correo'],
      contrasena: json['contrasena'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreUsuario': nombreUsuario,
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, nombreUsuario: $nombreUsuario, correo: $correo, contrasena: $contrasena}';
  }

}
