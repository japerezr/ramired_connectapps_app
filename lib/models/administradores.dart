import 'dart:convert';
import 'dart:typed_data';

class Administradores {
  final String rrAdministradoresId;
  final String rrFolio;
  final String rrNombre;
  final String rrApellido;
  final String rrDomicilio;
  final String rrTelefono;
  final String rrCorreoElectronico;
  final String rrUser;
  final String rrPassword;
  final String rrImagenId;
  final String rrImagenUrl;
  final String rrImageDecode;
  final String rrServicios;
  final String rrRoles;

  Administradores({
    required this.rrAdministradoresId,
    required this.rrFolio,
    required this.rrNombre,
    required this.rrApellido,
    required this.rrDomicilio,
    required this.rrTelefono,
    required this.rrCorreoElectronico,
    required this.rrUser,
    required this.rrPassword,
    required this.rrImagenId,
    required this.rrImagenUrl,
    required this.rrImageDecode,
    required this.rrServicios,
    required this.rrRoles,
  });

  factory Administradores.fromJson(Map<String, dynamic> json) {
    return Administradores(
      rrAdministradoresId: json['rr_administradoresid'] ?? '',
      rrFolio: json['rr_folio'] ?? '',
      rrNombre: json['rr_nombre'] ?? '',
      rrApellido: json['rr_apellido'] ?? '',
      rrDomicilio: json['rr_domicilio'] ?? '',
      rrTelefono: json['rr_telefono'] ?? '',
      rrCorreoElectronico: json['rr_correoelectronico'] ?? '',
      rrUser: json['rr_user'] ?? '',
      rrPassword: json['rr_password'] ?? '',
      rrImagenId: json['rr_imagenid'] ?? '',
      rrImagenUrl: json['rr_imagen_url'] ?? '',
      rrImageDecode: json['rr_imagedecode'] ?? '',
      rrServicios: json['rr_servicios'] ?? '',
      rrRoles: json['rr_roles'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rr_administradoresid': rrAdministradoresId,
      'rr_folio': rrFolio,
      'rr_nombre': rrNombre,
      'rr_apellido': rrApellido,
      'rr_domicilio': rrDomicilio,
      'rr_telefono': rrTelefono,
      'rr_correoelectronico': rrCorreoElectronico,
      'rr_user': rrUser,
      'rr_password': rrPassword,
      'rr_imagenid': rrImagenId,
      'rr_imagen_url': rrImagenUrl,
      'rr_imagedecode': rrImageDecode,
      'rr_servicios': rrServicios,
      'rr_roles': rrRoles,
    };
  }
}

class postAdministradores {
  String? rrAdministradoresId;
  String? rrNombre;
  String? rrApellido;
  String? rrDomicilio;
  String? rrTelefono;
  String? rrCorreoElectronico;
  String? rrUser;
  String? rrPassword;
  String? rrImageDecode;
  String? rrServicios;
  String? rrRoles;

  postAdministradores({
    this.rrAdministradoresId,
    this.rrNombre,
    this.rrApellido,
    this.rrDomicilio,
    this.rrTelefono,
    this.rrCorreoElectronico,
    this.rrUser,
    this.rrPassword,
    this.rrImageDecode,
    this.rrServicios,
    this.rrRoles,
  });

  factory postAdministradores.fromJson(Map<String, dynamic> json) {
    return postAdministradores(
      rrAdministradoresId: json['rr_administradoresid'] ?? '',
      rrNombre: json['rr_nombre'] ?? '',
      rrApellido: json['rr_apellido'] ?? '',
      rrDomicilio: json['rr_domicilio'] ?? '',
      rrTelefono: json['rr_telefono'] ?? '',
      rrCorreoElectronico: json['rr_correoelectronico'] ?? '',
      rrUser: json['rr_user'] ?? '',
      rrPassword: json['rr_password'] ?? '',
      rrImageDecode: json['rr_imagedecode'] ?? '',
      rrServicios: json['rr_servicios'] ?? '',
      rrRoles: json['rr_roles'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rr_administradoresid': rrAdministradoresId,
      'rr_nombre': rrNombre,
      'rr_apellido': rrApellido,
      'rr_domicilio': rrDomicilio,
      'rr_telefono': rrTelefono,
      'rr_correoelectronico': rrCorreoElectronico,
      'rr_user': rrUser,
      'rr_password': rrPassword,
      'rr_imagedecode': rrImageDecode,
      'rr_servicios': rrServicios,
      'rr_roles': rrRoles,
    };
  }
}