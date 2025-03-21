class Environment {

  //Local
  final API = "https://localhost:44308";

  //Test
  //final API = "https://bconnectapitest.azurewebsites.net";

  //Production
  // final API = "https://bconnect-auth-api.azurewebsites.net";

  final ROL_NAME = "Administrador";
  final SERVICE_NAME = "ALL";
  final WHATSAPP_NUMBER = "5219971250354";
  final FACEBOOK_URL = "https://www.facebook.com/RamiRedInternet";
  
  static final Environment _environment = Environment._internal();

  factory Environment() {
    return _environment;
  }

  Environment._internal();
}
