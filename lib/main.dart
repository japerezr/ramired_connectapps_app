import 'package:ramired_connectapps_app/app.dart';
import 'package:ramired_connectapps_app/helpers/preferences_helper.dart';
import 'package:ramired_connectapps_app/views/login_view.dart';
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

