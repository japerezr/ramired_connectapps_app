import 'package:ramired_connectapps_app/models/bc_colaborador.dart';
import 'package:ramired_connectapps_app/models/bc_user.dart';
import 'package:ramired_connectapps_app/views/account/account_view.dart';
import 'package:ramired_connectapps_app/views/busqueda/busquedas_view.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
import 'views/login_view.dart';

class AppRoute {
  static const String loginRoute = 'Login';
  static const String authRoute = 'Auth';
  static const String initialRoute = 'Inicio';
  static const String infoRoute = 'Info';

  static List<AppRouteItem> menuOptions = <AppRouteItem>[
    AppRouteItem(
      label: 'Login',
      route: 'Login',
      icon: Icons.security,
      screen: const LoginPage(),
    ),
    AppRouteItem(
      label: 'Inicio',
      route: 'Inicio',
      icon: Icons.edit_note,
      screen: const BusquedasPage(),
    ),
    AppRouteItem(
      label: 'Cuenta',
      route: 'Cuenta',
      icon: Icons.account_circle,
      screen: AccountPage(BCUser(), BCColaborador()),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {};
    for (var item in menuOptions) {
      routes.addAll({item.route: (context) => item.screen});
    }

    return routes;
  }
}
