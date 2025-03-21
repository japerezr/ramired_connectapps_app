import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import '../../models/_models.dart';
import '../../helpers/_helpers.dart';
import '../../components/_components.dart';

class Appbar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDialog;

  const Appbar({
    Key? key,
    required this.isDialog,
  }) : super(key: key);

  @override
  _AppbarState createState() => _AppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarState extends State<Appbar> {
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
    return AppBar(
      backgroundColor: Colors.blue,
      shadowColor: Colors.black,
      title: const Text(
        "NOVEL'S - CABINA & SPA",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      elevation: 2,
      actions: [
        Center(
          child: Text(
            user?.rrUser ?? '',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: AspectRatio(
            aspectRatio: 1,
            child: MaterialButton(
              shape: const CircleBorder(),
              color: Colors.transparent,
              padding: const EdgeInsets.all(0),
              onPressed: widget.isDialog
                  ? () {
                      onRegistered(context);
                    }
                  : null,
              child: imageBytes != null
                ? ClipOval(
                    child: Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                      width: 40,  // Tamaño adecuado para un avatar
                      height: 40,
                    ),
                  )
                : Icon(Icons.account_circle, size: 40, color: Colors.grey),

            ),
          ),
        ),
      ],
    );
  }

  Future<void> onRegistered(BuildContext context) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      enableDrag: false, // Deshabilita el cierre por deslizamiento
      isDismissible: false, // Evita que se cierre tocando fuera del modal
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          child: RegistroComponent(users: user),
        );
      },
    );
  }

  void _showColaboradorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(0),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                _itemCaption('UserName'),
                _itemDescription(Icons.numbers, user?.rrUser ?? ''),
                const SizedBox(height: 10),
                _itemCaption('Nombre'),
                _itemDescription(
                  Icons.person,
                  '${user?.rrNombre ?? ''} ${user?.rrApellido ?? ''}',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _itemCaption(String caption) {
    return Row(
      children: [
        const SizedBox(width: 40),
        const SizedBox(width: 5),
        Text(
          caption,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _itemDescription(IconData icon, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Icon(icon, size: 20),
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}