import 'package:flutter/material.dart';
import '../../services/_services.dart';
import '../models/_models.dart';
import '../helpers/_helpers.dart';
import 'dart:convert';
import '../../views/_views.dart';
import 'package:url_launcher/url_launcher.dart';
import '../env.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  Administradores? user;
  String whatsappNumber = Environment().WHATSAPP_NUMBER;
  String facebookUrl = Environment().FACEBOOK_URL;

  Future<void> login() async {
    try{
    setState(() {
      _isLoading = true;
    });
    user = await RamiRedService().getAdministrador(_userController.text, _passwordController.text);
    if(user != null){
      await PreferencesHelper.setString('user', jsonEncode(user?.toJson()));
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //backgroundColor: Colors.black,
      //duration: Duration(seconds: 3),
      //content: Text("Iniciando Sesión...")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      setState(() {
        _isLoading = false;
      });
    }else{
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
      content: Text(
           "Su usuario o contraseña son incorrectos.")));
    }
    }catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Text(
           "Ocurrió un error. Intente de nuevo más tarde.")));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchUrlW() async {
    final url = Uri.parse('https://wa.me/%2b$whatsappNumber');
    if (!await launchUrl(url)) {
      throw Exception('X Could not launch url');
    }
  }

  Future<void> _launchUrlF() async {
    final url = Uri.parse(facebookUrl);
    if (!await launchUrl(url)) {
      throw Exception('X Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset(
                  'assets/Banner1.png', // Reemplaza con la imagen que tengas en assets
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Usuario',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _userController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contraseña',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Iniciar'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Registrarse'),
                          ),
                        ),
                        const SizedBox(height: 20),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.facebook, color: Colors.blue, size: 40),
                              onPressed: () {
                                _launchUrlF();
                              },
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: Image.asset('assets/whatsapp.png', width: 40, height: 40),
                              onPressed: () {
                                _launchUrlW();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -75,
            left: 0,
            right: 0,
            child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ClipRect(
              child: Transform.scale(
                scaleY: 0.6,
                child: Image.asset(
                  'assets/BannerDown.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}


