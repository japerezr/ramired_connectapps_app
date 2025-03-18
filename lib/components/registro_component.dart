import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/_components.dart';
import 'package:image_picker/image_picker.dart';

class ActionDetailComponent extends StatefulWidget {

  const ActionDetailComponent({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActionDetailComponentState createState() => _ActionDetailComponentState();
}

class _ActionDetailComponentState extends State<ActionDetailComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerApellido = TextEditingController();
  final TextEditingController _controllerDomicilio = TextEditingController();
  final TextEditingController _controllerTelefono = TextEditingController();
  final TextEditingController _controllerEmail= TextEditingController();
  final TextEditingController _controllerUser= TextEditingController();
  final TextEditingController _controllerPassword= TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorNombre;
  String? _errorApellido;
  String? _errorDomicilio;
  String? _errorTelefono;
  String? _errorEmail;
  String? _errorUser;
  String? _errorPassword;
    Uint8List? _imageBytes;

  void _validateInput() {
    setState(() {
      _errorNombre = _controllerNombre.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorApellido = _controllerApellido.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorDomicilio = _controllerDomicilio.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorTelefono = _controllerTelefono.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorEmail = _controllerEmail.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorUser = _controllerUser.text.isEmpty ? 'Este campo no puede estar vacío' : null;
      _errorPassword = _controllerPassword.text.isEmpty ? 'Este campo no puede estar vacío' : null;
    });
  }

  Future<void> _pickImage() async {
      final picker = ImagePicker();
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Cámara'),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galería'),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );

      if (source != null) {
        final XFile? image = await picker.pickImage(source: source);
        if (image != null) {
          final bytes = await image.readAsBytes(); // Obtener los bytes de la imagen
          setState(() {
            _imageBytes = bytes; // Guardar los bytes en la variable
          });
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Registrar Usuario',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              const Divider(height: 0.5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                         Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                form(),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: const EdgeInsets.all(0), // Margen del Card
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child:null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          DividerComponent(text: "Datos Personales"),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerNombre,
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
              errorText: _errorNombre,
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerApellido,
            decoration: InputDecoration(
              labelText: 'Apellido',
              border: OutlineInputBorder(),
              errorText: _errorApellido,
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerDomicilio,
            decoration: InputDecoration(
              labelText: 'Domicilio',
              border: OutlineInputBorder(),
              errorText: _errorDomicilio,
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          DividerComponent(text: "Contactos"),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerTelefono,
            decoration: InputDecoration(
              labelText: 'Teléfono',
              border: OutlineInputBorder(),
              errorText: _errorTelefono,
            ),
            onChanged: (value) => _validateInput(),
            keyboardType: TextInputType.phone, // Solo acepta números
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Solo dígitos
              LengthLimitingTextInputFormatter(10), // Limita a 10 dígitos
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerEmail,
            decoration: InputDecoration(
              labelText: 'Correo Electronico',
              border: OutlineInputBorder(),
              errorText: _errorEmail,
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          DividerComponent(text: "Perfil"),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerUser,
            decoration: InputDecoration(
              labelText: 'Usuario',
              border: OutlineInputBorder(),
              errorText: _errorUser,
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controllerPassword,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
              errorText: _errorPassword, // Asigna el error aquí
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            onChanged: (value) => _validateInput(),
          ),
          const SizedBox(height: 20),
          DividerComponent(text: "Imagen"),
          const SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaciado uniforme entre los elementos
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Seleccionar Imagen'),
                ),
                if (_imageBytes != null)
                  Image.memory(_imageBytes!, width: 100, height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
  

  
  

}
