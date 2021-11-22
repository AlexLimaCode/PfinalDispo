// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inicio.dart';
import 'contacto.dart';
import 'perfil.dart';
import 'rutas.dart';
import 'scanBarCode.dart';

class inicio extends StatelessWidget {
  static const String nombreRuta = '/inicio';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ventas',
      home: scanBarCode(),
    );
  }
}
// TODO Implement this library.