import '../../env.dart';
import '../../helpers/preferences_helper.dart';
import '../../views/login_view.dart';
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
                const LoginPage(),
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

  }

  Future<void> removePreferences() async {
    await PreferencesHelper.remove('userkey');
    await PreferencesHelper.remove('token');
    await PreferencesHelper.remove('user');
    await PreferencesHelper.remove('firebase_user');
    await PreferencesHelper.remove('colaborador');
  }

}
