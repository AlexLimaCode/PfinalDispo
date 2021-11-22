// TODO Implement this library.// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage('https://picsum.photos/250?image=9'))),
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 12,
          left: 16,
          child: Text("Ejemplo",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        )
      ],
    ),
  );
}
