// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'venta.dart';
import 'contacto.dart';
import 'aProveedor.dart';
import 'rutas.dart';
import 'scanBarCode.dart';
import 'aProducto.dart';

class venta extends StatelessWidget {
  static const String nombreRuta = '/inicio';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ventas',
      home: scanBarCode(),
    );
  }
}
// TODO Implement this library.