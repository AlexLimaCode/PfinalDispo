// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, deprecated_member_use, unnecessary_const, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'scanBarCode.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class producto extends StatelessWidget {
  static const String nombreRuta = '/producto';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFC5C5),
      appBar: AppBar(
        backgroundColor: Color(0xffF05151),
        elevation: 0.0,
        title: Text(
          "Alta de Productos",
          style: TextStyle(
              fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: navigationDrawer(),
      body: MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombrectr = new TextEditingController();
  final TextEditingController _precioCompra = new TextEditingController();
  final TextEditingController _precioVenta = new TextEditingController();
  List itemsProveedor = [];
  String dropdownValue = 'One';
  String _scanBarcode = 'No ingresado';
  CollectionReference _productos =
      FirebaseFirestore.instance.collection('productos');
  CollectionReference _proveedores =
      FirebaseFirestore.instance.collection('proveedores');
  Future getProveedores() async {
    try {
      var provedores = await _proveedores.get();
      itemsProveedor.clear();
      print("Aqui");
      print('Manda  = ${provedores.size}');
      var i = 0;
      provedores.docs.forEach((element) {
        i = i + 1;
        setState(() {
          itemsProveedor.add(element["nombre"]);
        });
        print("valor de i = ${i}");
      });
      if (dropdownValue == 'One') {
        setState(() {
          dropdownValue = itemsProveedor[0];
        });
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nombrectr.text = documentSnapshot['nombre'];
      _precioCompra.text = documentSnapshot['precioCompra'].toString();
      _precioVenta.text = documentSnapshot['precioVenta'].toString();
      _scanBarcode = documentSnapshot['codigoBarra'].toString();
      dropdownValue = documentSnapshot['proveedor'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nombrectr,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _precioCompra,
                  decoration: const InputDecoration(
                    labelText: 'Compra',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _precioVenta,
                  decoration: const InputDecoration(
                    labelText: 'Venta',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Insertar' : 'Actualizar'),
                  onPressed: () async {
                    final String? nombre = _nombrectr.text;
                    final String? precioCompra = _precioCompra.text.toString();
                    final String? precioVenta = _precioVenta.text.toString();
                    final String? codigo = _scanBarcode.toString();
                    final String? proveedor = dropdownValue.toString();
                    if (nombre != null &&
                        precioCompra != null &&
                        precioVenta != null &&
                        codigo != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productos.add({
                          "nombre": nombre,
                          "precioCompra": precioCompra,
                          "precioVenta": precioVenta,
                          "proveedor": proveedor,
                          "codigoBarra": codigo
                        });
                      }

                      // if (action == 'update') {
                      //   // Update the product
                      //   await _productos
                      //       .doc(documentSnapshot!.id)
                      //       .update({"nombre": nombre, "precioCompra": precioCompra, "precioVenta": precioVenta});
                      // }

                      // Clear the text fields
                      _nombrectr.text = '';
                      _precioCompra.text = '';
                      _precioVenta.text = '';
                      setState(() {
                        _scanBarcode = 'No ingresado';
                        dropdownValue = itemsProveedor[0];
                      });

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

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
    // Build a Form widget using the _formKey created above.
    getProveedores();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nombrectr,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Nombre del Producto',
              labelText: 'Nombre',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _precioCompra,
            decoration: const InputDecoration(
              icon: const Icon(Icons.money_off_csred_outlined),
              hintText: 'Precio del producto en compra',
              labelText: 'Precio',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _precioVenta,
            decoration: const InputDecoration(
              icon: const Icon(Icons.money_rounded),
              hintText: 'Precio del producto en venta',
              labelText: 'Precio',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: itemsProveedor.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              alignment: Alignment.center,
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Text('Escanear QR')),
                    const SizedBox(
                      height: 30,
                    ),
                    Text('Producto : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ])),
          const SizedBox(
            height: 30,
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: RaisedButton(
                onPressed: () => _createOrUpdate(),
                child: Icon(Icons.add),
              )),
        ],
      ),
    );
  }
}
