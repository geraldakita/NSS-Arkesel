// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:digital_passport/sql_helper.dart';
import 'package:digital_passport/passportnumber_data.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    SQLHelper.db();
  }

  final TextEditingController _passportNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 43, 70, 62),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "PASSPORT",
              style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 212, 175, 55),
                  fontFamily: "Brand-Bold",
                  letterSpacing: 8),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 43, 70, 62),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 175,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 43, 70, 62),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.perm_identity_sharp,
                          color: Color.fromARGB(255, 212, 175, 55),
                          size: 150,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 175,
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("assets/ECOWAS_logo1.png"),
                          width: 90,
                          height: 90,
                          alignment: Alignment.center,
                        ),
                        Text(
                          "REPUBLIC OF GHANA",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Brand-Bold"),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Passport No:",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 212, 175, 55),
                fontFamily: "Brand-Bold",
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _passportNoController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 212, 175, 55),
                  fontFamily: "Brand-Bold",
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 212, 175, 55))),
                  hintText: 'Enter passport number',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Password:",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 212, 175, 55),
                fontFamily: "Brand-Bold",
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(
                  color: Color.fromARGB(255, 212, 175, 55),
                  fontFamily: "Brand-Bold",
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 212, 175, 55))),
                  hintText: 'Enter password',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  final String passportNo = _passportNoController.text;
                  final String password = _passwordController.text;

                  bool loggedIn =
                      await SQLHelper().loginUser(passportNo, password);

                  if (loggedIn) {
                    // Navigate to the home screen or perform any other action.
                    // Example: Navigator.pushReplacementNamed(context, '/home');
                    print('Logged in successfully');
                    Get.snackbar("Login", "Logged in Successfully",
                        colorText: Colors.white,
                        titleText: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 212, 175, 55)),
                        ),
                        messageText: const Text(
                          "Logged in Successfully",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 212, 175, 55)),
                        ));
                    final dataClass =
                        Provider.of<DataClass>(context, listen: false);
                    dataClass.changeNumber(passportNo.toString());
                    Navigator.pushNamed(context, '/bio');
                  } else {
                    // Display an error message or alert.
                    print('Login Failed');
                    Get.snackbar("Login", "Login Failed",
                        // backgroundColor: Colors.black,
                        colorText: Colors.white,
                        titleText: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 212, 175, 55)),
                        ),
                        messageText: const Text(
                          "Login Failed",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 212, 175, 55)),
                        ));
                    Navigator.pushNamed(context, '/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 212, 175, 55),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 43, 70, 62),
                    fontFamily: "Brand-Bold",
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "New here?",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Brand-Regular",
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
