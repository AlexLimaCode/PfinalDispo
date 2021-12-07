// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'venta.dart';

class registro extends StatelessWidget {
  const registro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'registro Screen',
      home: registroScreen(),
    );
  }
}

class registroScreen extends StatefulWidget {
  const registroScreen({Key? key}) : super(key: key);

  @override
  State<registroScreen> createState() => _registroScreenState();
}

class _registroScreenState extends State<registroScreen> {
  bool? isChecked = false;
  String error = "";
  String pass = "";
  final TextEditingController _telefono = new TextEditingController();
  final TextEditingController _contrasenia = new TextEditingController();
  final TextEditingController _nombre = new TextEditingController();
  final TextEditingController _negocio = new TextEditingController();
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
    if (_telefono.text.toString() != "" &&
        _contrasenia.text.toString() != "" &&
        _nombre.text.toString() != "" &&
        _negocio.text.toString() != "") {
      var pProductos = await _users.add({
        "nombre": _nombre.text.toString(),
        "telefono": _telefono.text.toString(),
        "tienda": _negocio.text.toString(),
        "contrasenia": _contrasenia.text.toString(),
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    } else {
      setState(() {
        error = "Rellena todos los campos";
      });
    }
  }

  Widget _buildregistroButton() {
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
          onTap: () {},
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
                    'Registrate',
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
                    height: 30,
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    child: TextField(
                      controller: _negocio,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFF5180ff),
                        prefixIcon: Icon(Icons.person_add, color: Colors.white),
                        hintText: "Ingresa el nombre de tu negocio",
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 2,
                    child: TextField(
                      controller: _nombre,
                      cursorColor: Colors.white,
                      cursorWidth: 2,
                      obscureText: false,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFF5180ff),
                        prefixIcon: Icon(Icons.face, color: Colors.white),
                        hintText: "Ingresa el nombre del administrador",
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PTSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildregistroButton(),
                  const SizedBox(
                    height: 15,
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
