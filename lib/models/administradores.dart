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
  final int rrRol;
  final String rrRolName;
  final String rrUser;
  final String rrPassword;
  final String rrImagenId;
  final String rrImagenUrl;
  final String rrImageDecode;

  Administradores({
    required this.rrAdministradoresId,
    required this.rrFolio,
    required this.rrNombre,
    required this.rrApellido,
    required this.rrDomicilio,
    required this.rrTelefono,
    required this.rrCorreoElectronico,
    required this.rrRol,
    required this.rrRolName,
    required this.rrUser,
    required this.rrPassword,
    required this.rrImagenId,
    required this.rrImagenUrl,
    required this.rrImageDecode,
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
      rrRol: json['rr_rol'] ?? 0,
      rrRolName: json['rr_rolname'] ?? '',
      rrUser: json['rr_user'] ?? '',
      rrPassword: json['rr_password'] ?? '',
      rrImagenId: json['rr_imagenid'] ?? '',
      rrImagenUrl: json['rr_imagen_url'] ?? '',
      rrImageDecode: json['rr_imagedecode'] ?? '',
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
      'rr_rol': rrRol,
      'rr_rolname': rrRolName,
      'rr_user': rrUser,
      'rr_password': rrPassword,
      'rr_imagenid': rrImagenId,
      'rr_imagen_url': rrImagenUrl,
      'rr_imagedecode': rrImageDecode,
    };
  }
}