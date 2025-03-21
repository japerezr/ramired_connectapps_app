import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramired_connectapps_app/models/administradores.dart';
import '../../components/_components.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/_services.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class RegistroComponent extends StatefulWidget {
  final Administradores? users;
  const RegistroComponent({
    Key? key,
    this.users
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistroComponentState createState() => _RegistroComponentState();
}

class _RegistroComponentState extends State<RegistroComponent> {
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
  String? imageBase64;
  Uint8List? imageBytes;
  bool _isLoading = false;
  postAdministradores? data;

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
      _controllerNombre.text = widget.users!.rrNombre ?? '';
      _controllerApellido.text = widget.users!.rrApellido ?? '';
      _controllerDomicilio.text = widget.users!.rrDomicilio ?? '';
      _controllerTelefono.text = widget.users!.rrTelefono ?? '';
      _controllerEmail.text = widget.users!.rrCorreoElectronico ?? '';
      _controllerUser.text = widget.users!.rrUser ?? '';
      _controllerPassword.text = widget.users!.rrPassword ?? '';
      imageBytes = base64Decode(widget.users!.rrImageDecode!);
    } catch (ex) {
      print('X Error en initUser: $ex');
    }
  }

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
          final bytes = await image.readAsBytes();
          final base64Image = base64Encode(bytes);
          setState(() {
            imageBytes = bytes;
            imageBase64 = base64Image;
          });
        }
      }
  }
  
  Future<void> _clearImage()async {
    setState(() {
      imageBytes = null;
      imageBase64 = null;
    });
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
                            const SizedBox(height: 100),
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
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Guardar'),
                ),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Seleccionar Imagen'),
                    ),
                    if (imageBytes != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.memory(imageBytes!, fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: GestureDetector(
                              onTap: _clearImage,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

        ],
      ),
    );
  }

  Future<void> save() async {

    _validateInput();

    if (_errorNombre != null || _errorApellido != null ||
        _errorDomicilio != null || _errorTelefono != null ||
        _errorEmail != null || _errorUser != null ||
        _errorPassword != null) 
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        content: Text("Por favor, complete todos los campos correctamente."),
      ));
      return;
    }

    try{
    setState(() {
      _isLoading = true;
    });

    var uuid = Uuid();
    String guid = uuid.v4();

    data = postAdministradores(
        rrAdministradoresId: guid,
        rrNombre: _controllerNombre.text,
        rrApellido: _controllerApellido.text,
        rrDomicilio: _controllerDomicilio.text,
        rrTelefono: _controllerTelefono.text,
        rrCorreoElectronico: _controllerEmail.text,
        rrUser: _controllerUser.text,
        rrPassword: _controllerPassword.text,
        rrImageDecode: imageBase64,
        rrServicios: "ALL",
        rrRoles: "Usuario" 
    );

    final result = await RamiRedService().saveUser(data!);
      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        content: Text("Registrando Usuario...")));
        Navigator.pop(context);
        setState(() {
          _isLoading = false;
        });
      }else{
        setState(() {
        _isLoading = false;
      });
      }
    }catch(ex){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
      content: Text(
           "Ocurrió un error. Intente de nuevo más tarde.")));
      setState(() {
        _isLoading = false;
      });
    }
  }

}
