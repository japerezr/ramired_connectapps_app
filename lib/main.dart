import '../../app.dart';
import '../../helpers/preferences_helper.dart';
import '../../views/_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(
      home: await initApp(),
      builder: EasyLoading.init(),
    ),
  );
}

Future<Widget?> initApp() async {
  return const LoginPage();
}

