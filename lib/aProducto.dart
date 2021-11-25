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
  final TextEditingController _precio = new TextEditingController();
  String dropdownValue = 'One';
  CollectionReference _proveedores =
      FirebaseFirestore.instance.collection('proveedores');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      print("Hola");
      action = 'update';
      _nombrectr.text = documentSnapshot['nombre'];
      _precio.text = documentSnapshot['telefono'].toString();
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
                  controller: _precio,
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
                    final int? telefono = int.tryParse(_precio.text);
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
                      _precio.text = '';

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
              hintText: 'Nombre del Producto',
              labelText: 'Nombre',
            ),
          ),
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: _precio,
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Precio del producto',
              labelText: 'Precio',
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
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
