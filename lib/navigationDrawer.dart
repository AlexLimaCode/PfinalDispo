// ignore_for_file: camel_case_types, use_key_in_widget_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'rutas.dart';
import 'createDrawerHeader.dart';
import 'createDrawerBodyItem.dart';

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
                  Navigator.pushReplacementNamed(context, rutas.rutaVenta)),
          createDrawerBodyItem(
              icon: Icons.person_add,
              text: ("Alta Proveedor"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, rutas.rutaProveedor)),
          createDrawerBodyItem(
              icon: Icons.face,
              text: ("Alta Producto"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, rutas.rutaProducto)),
          createDrawerBodyItem(
              icon: Icons.contact_mail,
              text: ("Contacto"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, rutas.rutacontacto)),
        ],
      ),
    );
  }
}
