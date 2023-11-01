import 'package:digital_passport/SplashScreen.dart';
import 'package:digital_passport/bio.dart';
import 'package:digital_passport/login.dart';
import 'package:digital_passport/passportnumber_data.dart';
import 'package:digital_passport/register.dart';
import 'package:digital_passport/visas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MaterialApp(

//     debugShowCheckedModeBanner: false,
//     initialRoute: '/',
//     routes: {
//       '/': (context) => SplashScreen(),
//       '/register': (context) => Register(),
//       '/bio': (context) => Bio(),
//       '/login': (context) => Login(),
//     },
//   ));
// }

// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => DataClass(),
//     child: MaterialApp(
//       debugShowCheckedModeBanner: false,
//     initialRoute: '/',
//     routes: {
//       '/': (context) => SplashScreen(),
//       '/register': (context) => Register(),
//       '/bio': (context) => Bio(),
//       '/login': (context) => Login(),
//     },
//     ),
//   ));
// }

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DataClass(),
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/register': (context) => Register(),
        '/bio': (context) => Bio(),
        '/login': (context) => Login(),
        '/visa': (context) => Visas()
      },
    ),
  ));
}
