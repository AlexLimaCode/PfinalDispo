// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';

class perfil extends StatelessWidget {
  static const String nombreRuta = '/perfil';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('perfil'),
        ),
        drawer: navigationDrawer(),
        body: Center(
          child: Text('soy perfil'),
        ));
  }
}
// TODO Implement this library.