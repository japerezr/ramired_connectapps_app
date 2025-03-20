import 'dart:convert';
import '../../env.dart';
import '../../models/_models.dart';
import 'package:http/http.dart' as http;


class RamiRedService {
  String? token;
  String apiUrl = Environment().API;

  Future<Administradores?> loginAdministrador(String user, String password) async {
    try {
      Administradores? object;
      final response = await http.get(
        Uri.parse('$apiUrl/auth/loginAdministrador?user=$user&password=$password'),
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

    Future<String?> saveUser(postAdministradores data) async {
    try {
      String? object;
      final jsonData = jsonEncode(data.toJson());
      final response = await http.post(
        Uri.parse('$apiUrl/auth/registerAdministrador'),
        body: jsonData,
        headers: {
          "Content-Type": "application/json", 
          "Accept": "application/json"
        },
      );
      if (response.statusCode == 200) {
          final String responseBody = response.body;
          object = responseBody;
      }
      return object;
    } catch (e) {
      throw Exception(e);
    }
  }

}
