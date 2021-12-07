import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../login.dart';

class ScrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Algo",
      home: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Page1(),
          Page3(),
          Page2(),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background(),
        MainContent(),
      ],
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Bienvenido',
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffef8354))),
          Text('Tu App para andar 24/7',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffef8354))),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down_rounded,
              size: 100, color: Color(0xffa98467)),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xffb5e48c),
      // height: double.infinity,
      // alignment: Alignment.topCenter,
      // child: Image(
      //   image: AssetImage('assets/esquina2.jpeg'),
      // ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/esquina2.jpeg'), fit: BoxFit.cover),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffb5e48c),
      child: Center(
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => login()));
          },
          child: Text('  COMENZAR  ',
              style: TextStyle(color: Colors.white, fontSize: 30)),
          style: TextButton.styleFrom(
              backgroundColor: Color(0xffadc178), shape: StadiumBorder()),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Fondo(),
        Contenido(),
      ],
    );
  }
}

class Contenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Acerca de:',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff9c89b8))),
          Text(''),
          Text(
              'El funcionamiento de esta App se encuentra orientado hacia el registro y escaneo de productos autorizados para la facilitación de un conteo de su venta',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff3c096c))),
          Text(''),
          Text(
              'De modo que; Para iniciar la utilización de la misma, tienes que registrar una cuenta prosiguiendo a llenar los campos que a continuación se mostrarán en pantalla',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff1b4965))),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down_rounded,
              size: 100, color: Color(0xffef8354)),
        ],
      ),
    );
  }
}

class Fondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/esquina5.jpeg'), fit: BoxFit.cover),
      ),
    );
  }
}
