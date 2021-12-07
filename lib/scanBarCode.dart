// ignore_for_file: avoid_print, file_names, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_collection_literals, unnecessary_new, unused_field, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:proyectofinal/total.dart';
import 'rutas.dart';
import 'contacto.dart';
import 'venta.dart';
import 'navigationDrawer.dart';
import 'aProveedor.dart';
import 'total.dart';

class scanBarCode extends StatefulWidget {
  @override
  _scanBarCodeState createState() => _scanBarCodeState();
}

class _scanBarCodeState extends State<scanBarCode> {
  String _scanBarcode = 'No ingresado';
  List<int> productos = [];
  List<double> precios = [];
  List<String> nombres = [];
  List<double> costos = [];
  CollectionReference _productos =
      FirebaseFirestore.instance.collection('productos');
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      setState(() {
        productos.add(int.parse(barcodeScanRes));
      });
      print("Aqui = ${productos}");
      var pProductos = await _productos
          .where('codigoBarra', isEqualTo: barcodeScanRes.toString())
          .get();
      if (pProductos.docs.length > 0) {
        pProductos.docs.forEach((element) {
          setState(() {
            precios.add(double.parse(element["precioVenta"]));
            nombres.add(element["nombre"].toString());
            costos.add(double.parse(element["precioCompra"]));
          });
        });
        print("precio venta = ${precios}");
        print("costo venta = ${costos}");
        print("nombre venta = ${nombres}");
      } else {
        setState(() {
          barcodeScanRes = "No existe ese producto";
        });
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffEFC5C5),
        appBar: AppBar(
          backgroundColor: Color(0xffF05151),
          elevation: 0.0,
          title: Text(
            "Venta en tienda",
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: navigationDrawer(),
        body: Builder(builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Ingresa producto por producto, al finalizar click en total",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Helvetica",
                      color: Colors.black,
                      fontSize: 25,
                      wordSpacing: 3),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () => scanBarcodeNormal(),
                  child: Text('Escanear QR'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Producto : $_scanBarcode\n',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => total(precios, nombres)));
                  },
                  child: Text('Total'),
                ),
              ],
            ),
          );
        }),
      ),
      routes: {
        rutas.rutaVenta: (context) => venta(),
        rutas.rutacontacto: (context) => contacto(),
        rutas.rutaProveedor: (context) => proveedor(),
      },
    );
  }
}
