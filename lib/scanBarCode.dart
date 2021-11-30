// ignore_for_file: avoid_print, file_names, camel_case_types, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'rutas.dart';
import 'contacto.dart';
import 'venta.dart';
import 'navigationDrawer.dart';
import 'aProveedor.dart';

class scanBarCode extends StatefulWidget {
  @override
  _scanBarCodeState createState() => _scanBarCodeState();
}

class _scanBarCodeState extends State<scanBarCode> {
  String _scanBarcode = 'No ingresado';

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
      home: Scaffold(
        appBar: AppBar(title: const Text('Barcode scan')),
        drawer: navigationDrawer(),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Text('Escanear QR')),
                    Text('Producto : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ]));
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
