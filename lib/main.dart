import '../../app.dart';
import '../../helpers/preferences_helper.dart';
import '../../views/_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(
      home: const SplashScreen(), // Primero muestra la pantalla de carga
      builder: EasyLoading.init(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<Widget?> initApp() async {
    try {
      final jsonAdministrador = await PreferencesHelper.getString('user');
      if (jsonAdministrador != null) {
        return const HomePage();
      } else {
        return const LoginPage();
      }
    } catch (ex) {
      debugPrint('X Error: $ex');
      return const LoginPage(); // En caso de error, muestra Login
    }
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2)); // Espera 3 segundos
    Widget? nextPage = await initApp();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextPage ?? const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: Column(
        children: [
          Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.png', // Ruta del icono (debe estar en assets)
                  width: 150, // Tamaño del icono
                  height: 150,
                ),
                SizedBox(height: 20),
                CircularProgressIndicator( // Icono de carga en blanco
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ajusta al contenido
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // Ajusta este valor para reducir el espacio
                Image.asset(
                  'assets/banner.png',
                  width: 100,
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}