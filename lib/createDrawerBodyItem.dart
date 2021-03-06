// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal/screens/scroll_design.dart';

Widget createDrawerBodyItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(children: <Widget>[
      Icon(icon),
      Padding(padding: EdgeInsets.only(left: 8.0), child: Text(text!))
    ]),
    onTap: onTap,
  );
}
