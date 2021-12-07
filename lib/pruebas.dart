// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, deprecated_member_use, unnecessary_const, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'login.dart';

class ScrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Algo",
      home: PageView(
        scrollDirection: Axis.vertical,
        children: [],
      ),
    );
  }
}
