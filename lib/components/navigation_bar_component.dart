import 'package:ramired_connectapps_app/app_route.dart';
import 'package:ramired_connectapps_app/env.dart';
import 'package:ramired_connectapps_app/helpers/preferences_helper.dart';
import 'package:ramired_connectapps_app/views/busqueda/busquedas_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBarComponenet extends StatefulWidget {
  final int selectedNavBarIndex;
  const NavigationBarComponenet(this.selectedNavBarIndex, {super.key});

  @override
  State<NavigationBarComponenet> createState() =>
      _NavigationBarComponenetState();
}

class _NavigationBarComponenetState extends State<NavigationBarComponenet> {
  String whatsappNumber = Environment().WHATSAPP_NUMBER;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app_rounded),
          label: 'Salir',
        ),
      ],
      currentIndex: widget.selectedNavBarIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => onNavBarTapped(context, index),
    );
  }

  void onNavBarTapped(BuildContext context, int index) {
    if (widget.selectedNavBarIndex == index) return;
    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const BusquedasPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false,
        );
        break;
      case 1:
        onSignOut(context);
        break;
      default:
    }
  }

  Future<void> onSignOut(BuildContext context) async {
    await removePreferences();
    if (!mounted) return;
    await launchWhatsApp(context);
  }

  Future<void> removePreferences() async {
    await PreferencesHelper.remove('userkey');
    await PreferencesHelper.remove('token');
    await PreferencesHelper.remove('user');
    await PreferencesHelper.remove('firebase_user');
    await PreferencesHelper.remove('colaborador');
  }

  Future<void> launchWhatsApp(
    BuildContext context,
  ) async {
    String message = '';
    final url = Uri.parse('https://wa.me/$whatsappNumber?text=$message');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch url');
    }
    if (!mounted) return;
    await Navigator.pushNamedAndRemoveUntil(
        context, AppRoute.loginRoute, (route) => false);
  }
}
