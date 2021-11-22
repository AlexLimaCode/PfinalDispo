// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';

class contacto extends StatelessWidget {
  static const String nombreRuta = '/contacto';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('contacto'),
        ),
        drawer: navigationDrawer(),
        body: Center(
          child: Text('soy contacto'),
        ));
  }
}
// TODO Implement this library.