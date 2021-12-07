// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:io';

import 'navigationDrawer.dart';

class contacto extends StatelessWidget {
  static const String nombreRuta = '/proveedor';
  llamada() async {
    const url = 'tel:+527222743024';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Errror al contactar a $url';
    }
  }

  mensaje(String msj, List<String> d) async {
    String r =
        await sendSMS(message: msj, recipients: d).catchError((Object error) {
      print(error);
    });
    print(r);
  }

  openwhatsapp(String message, String destinatario) async {
    var whatsapp = destinatario;
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=" + message;
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse(message)}";

    if (Platform.isIOS) {
      // for iOS phone only
      try {
        await launch(whatappURL_ios, forceSafariVC: false);
      } catch (e) {
        print(
            e); // although the exception occurs, this never happens, and I would rather catch the exact canLaunch exception
      }
    } else {
      try {
        await launch(whatsappURl_android);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEFC5C5),
        appBar: AppBar(
          backgroundColor: Color(0xffF05151),
          elevation: 0.0,
          title: Text(
            "Contacto",
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: navigationDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(25),
                width: 300,
                child: ElevatedButton(
                  onPressed: llamada,
                  child: Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Llamanos!", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    String msj = "Hola, quisiera una reservacion";
                    List<String> d = ["Invitado", "7222743024"];
                    mensaje(msj, d);
                  },
                  child: Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.message_outlined,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Enviar sms!", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
              Container(
                margin: EdgeInsets.all(25),
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    String destinatario = "+5217222743024";
                    String message = "¿Puedo reservar?";
                    openwhatsapp(destinatario, message);
                  },
                  child: Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.phone_android,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Whatsapp!", style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
              Container(
                padding: EdgeInsets.all(35),
                child: Text(
                  'Contacto: Feedback y reportes de malfuncionamiento, errores o dudas de la App.',
                  style: TextStyle(
                    fontFamily: 'PT-Sans',
                    fontSize: 35,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
