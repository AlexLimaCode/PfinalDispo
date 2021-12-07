import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'venta.dart';
import 'registro.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Screen',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool? isChecked = false;
  String error = "";
  String pass = "";
  final TextEditingController _telefono = new TextEditingController();
  final TextEditingController _contrasenia = new TextEditingController();
  CollectionReference _users =
      FirebaseFirestore.instance.collection('usuarios');

  Widget _buildTextField({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? controller,
  }) {
    if (controller == "1") {
      return Material(
        color: Colors.transparent,
        elevation: 2,
        child: TextField(
          controller: _telefono,
          keyboardType: TextInputType.numberWithOptions(decimal: false),
          cursorColor: Colors.white,
          cursorWidth: 2,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xFF5180ff),
            prefixIcon: prefixedIcon,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontFamily: 'PTSans',
            ),
          ),
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        elevation: 2,
        child: TextField(
          controller: _contrasenia,
          cursorColor: Colors.white,
          cursorWidth: 2,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Color(0xFF5180ff),
            prefixIcon: prefixedIcon,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontFamily: 'PTSans',
            ),
          ),
        ),
      );
    }
  }

  void traeUsers() async {
    print("Entro aqui");
    print("Ay va ${_telefono.text.toString()}");
    if (_telefono.text.toString() != "" && _contrasenia.text.toString() != "") {
      print("entro en if");
      var pProductos = await _users
          .where('telefono', isEqualTo: _telefono.text.toString())
          .get();
      if (pProductos.docs.length > 0) {
        print("entro if2");
        pProductos.docs.forEach((e) => {
              setState(() {
                pass = e["contrasenia"];
              })
            });
        print("pass = ${pass}");
        if (pass == _contrasenia.text.toString()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => venta()));
        } else {
          setState(() {
            error = "Ingresa un usuario y contraseña validos";
          });
        }
      } else {
        setState(() {
          error = "Ingresa un usuario y contraseña validos";
        });
      }
    } else {
      setState(() {
        error = "Ingresa un usuario y contraseña validos";
      });
    }
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: const Text(
          'Iniciar',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          traeUsers();
        },
      ),
    );
  }

  Widget _buildLogoButton({
    required String image,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }

  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No tienes una cuenta? ',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        InkWell(
          child: const Text(
            'Registrarse',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => registro()));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF5967ff),
                Color(0xFF5374ff),
                Color(0xFF5180ff),
                Color(0xFF538bff),
                Color(0xFF5995ff),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Telefono',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextField(
                    hintText: 'Ingresa tu telefono',
                    obscureText: false,
                    prefixedIcon: const Icon(Icons.phone, color: Colors.white),
                    controller: "1",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Contraseña',
                      style: TextStyle(
                        fontFamily: 'PT-Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextField(
                      hintText: 'Ingresa tu contraseña',
                      obscureText: true,
                      prefixedIcon: const Icon(Icons.lock, color: Colors.white),
                      controller: "2"),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildLoginButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSignUpQuestion(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    error.toString(),
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
