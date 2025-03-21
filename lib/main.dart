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
    await Future.delayed(const Duration(seconds: 3)); // Espera 3 segundos
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
      body: Center(
        child: Image.asset(
          'assets/banner.png', // Ruta del icono (debe estar en assets)
          width: 150, // Tamaño del icono
          height: 150,
        ),
      ),
    );
  }
}