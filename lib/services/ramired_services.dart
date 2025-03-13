import 'dart:convert';
import '../../env.dart';
import '../../models/_models.dart';
import 'package:http/http.dart' as http;


class RamiRedService {
  String? token;
  String apiUrl = Environment().API;

  Future<Administradores?> getAdministrador(String user, String password) async {
    try {
      Administradores? object;
      final response = await http.get(
        Uri.parse('$apiUrl/sabbat/getAdministrador?user=$user&password=$password'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        object = Administradores.fromJson(result);
      }
      return object;
    } catch (e) {
      throw Exception(e);
    }
  }

}
