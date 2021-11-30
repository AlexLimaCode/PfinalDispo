// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, deprecated_member_use, unnecessary_const, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:proyectofinal/navigationDrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class producto extends StatelessWidget {
  static const String nombreRuta = '/producto';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alta de Producto'),
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
  final TextEditingController _telefonoctr = new TextEditingController();

  CollectionReference _proveedores =
      FirebaseFirestore.instance.collection('proveedores');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      print("Hola");
      action = 'update';
      _nombrectr.text = documentSnapshot['nombre'];
      _telefonoctr.text = documentSnapshot['telefono'].toString();
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
                  controller: _telefonoctr,
                  decoration: const InputDecoration(
                    labelText: 'Telefono',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Insertar' : 'Actualizar'),
                  onPressed: () async {
                    final String? nombre = _nombrectr.text;
                    final int? telefono = int.tryParse(_telefonoctr.text);
                    if (nombre != null && telefono != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _proveedores
                            .add({"nombre": nombre, "precio": telefono});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _proveedores
                            .doc(documentSnapshot!.id)
                            .update({"nombre": nombre, "precio": telefono});
                      }

                      // Clear the text fields
                      _nombrectr.text = '';
                      _telefonoctr.text = '';

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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nombrectr,
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Nombre del proveedor',
              labelText: 'Nombre',
            ),
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            controller: _telefonoctr,
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Telefono de contacto',
              labelText: 'Telefono',
            ),
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
