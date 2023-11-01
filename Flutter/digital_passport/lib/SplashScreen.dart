import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        Navigator.pushNamed(context, '/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(100, 43, 70, 62),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "ECONOMIC COMMUNITY OF\nWEST AFRICAN STATES\n(ECOWAS)",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Brand-Regular"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "COMMUNAUTE ECONOMIQUE DES\nETATS DE L'AFRIQUE DE L'OUEST\n(CEDEAO)",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Brand-Regular"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "REPUBLIC OF GHANA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "Brand-Bold"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    image: AssetImage("assets/ECOWAS_logo1.png"),
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "PASSPORT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Brand-Bold"),
                  ),
                  Text(
                    "PASSEPORT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Brand-Bold"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SpinKitFoldingCube(
                    color: Color.fromARGB(255, 212, 175, 55),
                    size: 50.0,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
