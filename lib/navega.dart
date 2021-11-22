import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inicio.dart';
import 'contacto.dart';
import 'perfil.dart';
import 'rutas.dart';

class navega extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'navegacion drawer',
      home: inicio(),
      routes: {
        rutas.rutainicio: (context) => inicio(),
        rutas.rutacontacto: (context) => contacto(),
        rutas.rutaperfil: (context) => perfil(),
      },
    );
  }
}
