import 'package:flutter/material.dart';
import '../../services/_services.dart';
import '../models/_models.dart';
import '../helpers/_helpers.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Administradores? user;

  Future<void> login() async {
    try{
    user = await RamiRedService().getAdministrador(_userController.text, _passwordController.text);
    
    if(user != null){
      await PreferencesHelper.setString('user', jsonEncode(user?.toJson()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
      content: Text("Iniciando Sesión...")));
    }else{
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
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Iniciar'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Lógica de registro aquí
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black),
                            ),
                            child: const Text('Registrarse'),
                          ),
                        ),
                        const SizedBox(height: 20),
                       Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.facebook, color: Colors.blue, size: 40),
                              onPressed: () {
                                // Lógica para Facebook
                              },
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: Image.asset('assets/whatsapp.png', width: 40, height: 40),
                              onPressed: () {
                                
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


