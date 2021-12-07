// ignore_for_file: camel_case_types, prefer_const_constructors, unused_field, prefer_final_fields, avoid_print, avoid_function_literals_in_foreach_calls, prefer_collection_literals, unnecessary_new, deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'venta.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class total extends StatefulWidget {
  final List<double> precios;
  final List<String> nombres;
  total(this.precios, this.nombres, {Key? key}) : super(key: key);

  @override
  _totalState createState() => _totalState();
}

class _totalState extends State<total> {
  late List<double> _precios = widget.precios;
  late List<String> _nombres = widget.nombres;
  final Map<String, double> ventaTotal = {};
  CollectionReference _ventas = FirebaseFirestore.instance.collection('ventas');
  double total = 0.0;
  List<String> valores = [];
  void imprime() {
    print("En total");
    for (var i = 0; i < _precios.length; i++) {
      ventaTotal.addAll({_nombres[i]: _precios[i]});
    }
    ventaTotal.forEach((key, value) =>
        {valores.add(key.toString() + " --- " + value.toString())});
    print("here = ${valores}");
    for (var i = 0; i < _precios.length; i++) {
      total = total + _precios[i];
    }
  }

  Widget listOfWidgets(List<String> valores) {
    List<Widget> list = [];
    for (var i = 0; i < valores.length; i++) {
      list.add(Container(
          child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          valores[i],
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Helvetica",
              color: Color(0xff4f5d75),
              fontSize: 25,
              wordSpacing: 5),
        ),
      )));
    }
    return Wrap(
        spacing: 15.0, // gap between adjacent chips
        runSpacing: 10.0, // gap between lines
        children: list);
  }

  void aceptarVenta() {
    final now = new DateTime.now();
    String formatter = now.toString();
    String cantidad = _precios.length.toString();
    String totalBD = total.toString();
    _ventas
        .add({
          'elementosVendidos': cantidad, // John Doe
          'fecha': formatter, // Stokes and Sons
          'totalVendido': totalBD // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    Navigator.push(context, MaterialPageRoute(builder: (context) => venta()));
  }

  @override
  Widget build(BuildContext context) {
    imprime();
    return Scaffold(
        backgroundColor: Color(0xffEFC5C5),
        appBar: AppBar(
          backgroundColor: Color(0xffF05151),
          elevation: 0.0,
          title: Text(
            "Total de venta",
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              listOfWidgets(valores),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
              ),
              Text(
                "Total = " + total.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Helvetica",
                    color: Color(0xff4f5d75),
                    fontSize: 25,
                    wordSpacing: 5),
              ),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => venta()));
                },
                child: Text('Cancelar Venta'),
              ),
              ElevatedButton(
                onPressed: () {
                  aceptarVenta();
                },
                child: Text('Aceptar'),
              ),
            ],
          ),
        ));
  }
}
