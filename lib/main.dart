import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'navega.dart';
//import 'pruebas.dart';
import 'login.dart';

import 'screens/scroll_design.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //CARGA DE MANERA ADECUADA LOS WIDGETS
  await Firebase.initializeApp();
  runApp(ScrollScreen());
}
