// ignore_for_file: camel_case_types, use_key_in_widget_constructors, file_names, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:proyectofinal/aProducto.dart';
import 'package:proyectofinal/contacto.dart';
import 'package:proyectofinal/venta.dart';
import 'rutas.dart';
import 'createDrawerHeader.dart';
import 'createDrawerBodyItem.dart';
import 'tasks.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
              icon: Icons.home,
              text: ("Ventas"),
              onTap: () =>
                  // Navigator.pushReplacementNamed(context, rutas.rutaVenta)),
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => venta()))),
          createDrawerBodyItem(
              icon: Icons.person_add,
              text: ("Alta Proveedor"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, rutas.rutaProveedor)),
          createDrawerBodyItem(
              icon: Icons.face,
              text: ("Alta Producto"),
              onTap: () =>
                  // Navigator.pushReplacementNamed(context, rutas.rutaProducto)),
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => producto()))),
          createDrawerBodyItem(
              icon: Icons.contact_mail,
              text: ("Contacto"),
              onTap: () => Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => contacto()))),
          createDrawerBodyItem(
              icon: Icons.pending,
              text: ("Pendientes"),
              onTap: () => Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => tasks()))),
        ],
      ),
    );
  }
}
