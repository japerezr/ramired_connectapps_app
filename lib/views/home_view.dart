import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/_models.dart';
import '../../helpers/_helpers.dart';
import '../../services/_services.dart';
import '../../components/_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Administradores? user;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        await initUser();
        setState(() {});
      }
    });
  }

  Future<void> initUser() async {
    try {
      final jsonAdministrador = await PreferencesHelper.getString('user');
      if (jsonAdministrador != null) {
        user = Administradores.fromJson(jsonDecode(jsonAdministrador));
        if (user?.rrImageDecode != null && user!.rrImageDecode!.isNotEmpty) {
          imageBytes = base64Decode(user!.rrImageDecode!);
        }
      }
    } catch (ex) {
      print('X Error en initUser: $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        isDialog: true,
      ),
      body: Center(
        
      ),
      bottomNavigationBar: const NavigationBars(0),
    );
  }
}
