import '../../env.dart';
import '../../helpers/preferences_helper.dart';
import '../../views/_views.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationBars extends StatefulWidget {
  final int selectedNavBarIndex;
  const NavigationBars(this.selectedNavBarIndex, {super.key});

  @override
  State<NavigationBars> createState() =>_NavigationBarState();
  
}

class _NavigationBarState extends State<NavigationBars> {
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
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(255, 212, 212, 212),
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
                const HomePage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false,
        );
        break;
      case 1:
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
    await PreferencesHelper.remove('user');
  }

}
