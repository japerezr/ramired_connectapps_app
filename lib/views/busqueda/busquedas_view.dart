// ignore_for_file: file_names
import 'dart:convert';
import 'package:ramired_connectapps_app/app_route.dart';
import 'package:ramired_connectapps_app/app_theme.dart';
import 'package:ramired_connectapps_app/env.dart';
import 'package:ramired_connectapps_app/views/account/account_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';
import '../../models/models.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../services/services.dart';
import 'package:ramired_connectapps_app/components/navigation_bar_component.dart';
import 'package:intl/intl.dart';

class BusquedasPage extends StatefulWidget {
  const BusquedasPage({super.key});

  @override
  State<BusquedasPage> createState() => _BusquedasPageState();
}

class _BusquedasPageState extends State<BusquedasPage> {
final _formKey = GlobalKey<FormState>();
BCUser? user;
BCColaborador? colaborador;

@override
Widget build(BuildContext context) {
  final userInitials =
        '${(user?.names ?? '') == '' ? '' : (user?.names ?? '').substring(0, 1)}${(user?.lastNames ?? '') == '' ? '' : (user?.lastNames ?? '').substring(0, 1)}';
  return Scaffold(
    appBar: BconnectAppBar(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => AccountPage(
                      user ?? BCUser(), colaborador ?? BCColaborador())))
        },
        userInitials: userInitials,
      ),
    bottomNavigationBar: const NavigationBarComponenet(0), // asume que esto es lo único que necesitas
  );
}
}