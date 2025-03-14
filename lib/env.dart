class Environment {

  //Local
  final API = "https://localhost:44308";

  //Test
  //final API = "https://bconnectapitest.azurewebsites.net";

  //Production
  // final API = "https://bconnect-auth-api.azurewebsites.net";

  final SERVICE_ID = "z593c9c6-b79f-4bf0-8ba2-fdb0a5345643"; //encuestas
  final SERVICE_NAME = "Encuestas";
  final WHATSAPP_NUMBER = "15165185350";
  final FACEBOOK_URL = "https://www.facebook.com/RamiRedInternet";
  
  static final Environment _environment = Environment._internal();

  factory Environment() {
    return _environment;
  }

  Environment._internal();
}
