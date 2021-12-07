// TODO Implement this library.// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://i.pinimg.com/564x/ac/13/49/ac1349dfe397de09cf1b54811387d2e4.jpg'))),
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 12,
          left: 16,
          child: Text("La de la esquina",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        )
      ],
    ),
  );
}
