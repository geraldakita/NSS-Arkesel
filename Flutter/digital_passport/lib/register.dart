import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:digital_passport/sql_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _passportNameController = TextEditingController();
  final TextEditingController _passportPasswordController =
      TextEditingController();
  final TextEditingController _passportGenderController =
      TextEditingController();
  final TextEditingController _passportTypeController = TextEditingController();
  final TextEditingController _passportNumberController =
      TextEditingController();
  final TextEditingController _passportNationalityController =
      TextEditingController();
  final TextEditingController _passportDoiController = TextEditingController();
  final TextEditingController _passportDoeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SQLHelper.db(); // Loading the diary when the app starts
  }

  void sendSMSv1() async {
    const id = 'Project-Nii';
    const apiKey =
        'OnJxY2k1aEhuRERqSlFXeGE='; // Replace with your Arkesel API key
    const recipientPhoneNumber =
        '233209152765'; // Replace with the recipient's phone number
    final message =
        'Hello ${_passportNameController.text},\nWelcome to the ECOWAS E-Passport\nThis is a confirmation of your new account creation.\nThe following are the details you entered:\nName: ${_passportNameController.text}\nGender: ${_passportGenderController.text}\nPassport Type: ${_passportTypeController.text}\nPassport Number: ${_passportNumberController.text}\nNationality: ${_passportNationalityController.text}\nDate of Issue: ${_passportDoiController.text}\nDate of Expiry: ${_passportDoeController.text}'; // Your message with line breaks
    final url = Uri.parse(
        'https://sms.arkesel.com/sms/api?action=send-sms&api_key=$apiKey&to=$recipientPhoneNumber&from=$id&sms=${Uri.encodeComponent(message)}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('SMS sent successfully');
      Get.snackbar(
          "SMS Confirmation", "Account created successfully. Check SMS",
          // backgroundColor: Colors.black,
          colorText: Colors.white,
          titleText: const Text(
            "SMS Confirmation",
            style: TextStyle(
                fontSize: 40, color: Color.fromARGB(255, 212, 175, 55)),
          ),
          messageText: const Text(
            "Account created successfully. Check SMS",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 212, 175, 55)),
          ));
    } else {
      print('Failed to send SMS. Status code: ${response.statusCode}');
    }
    print(response.body);
  }

  Future<void> sendSMSv2() async {
    const id = 'Project-Nii';
    const apiKey =
        'OnJxY2k1aEhuRERqSlFXeGE='; // Replace with your Arkesel API key
    const recipientPhoneNumber =
        '233209152765'; // Replace with the recipient's phone number
    final message =
        'Hello ${_passportNameController.text},\nWelcome to the ECOWAS E-Passport\nThis is a confirmation of your new account creation.\nThe following are the details you entered:\nName: ${_passportNameController.text}\nGender: ${_passportGenderController.text}\nPassport Type: ${_passportTypeController.text}\nPassport Number: ${_passportNumberController.text}\nNationality: ${_passportNationalityController.text}\nDate of Issue: ${_passportDoiController.text}\nDate of Expiry: ${_passportDoeController.text}'; // Your message with line breaks

    // Define the API endpoint URL for Arkesel's SMS V2 API
    const String apiUrl = 'https://sms.arkesel.com/api/v2/sms/send';

    // Create a map of the data you want to send in the POST request
    final Map<String, dynamic> data = {
      'sender': id,
      'recipients': [recipientPhoneNumber],
      'message': message,
    };

    // Encode the data as JSON
    final String jsonData = json.encode(data);

    // Create the headers with the API key
    final Map<String, String> headers = {
      'Content-Type': 'application/json', // Set the content type to JSON
      'api-key': apiKey, // Pass the API key in the Authorization header
    };

    // Make the POST request with headers
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonData, // Send the JSON-encoded data in the request body
    );

    if (response.statusCode == 200) {
      // Request was successful
      print('SMS sent successfully');
      Get.snackbar(
          "SMS Confirmation", "Account created successfully. Check SMS",
          // backgroundColor: Colors.black,
          colorText: Colors.white,
          titleText: const Text(
            "SMS Confirmation",
            style: TextStyle(
                fontSize: 40, color: Color.fromARGB(255, 212, 175, 55)),
          ),
          messageText: const Text(
            "Account created successfully. Check SMS",
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 212, 175, 55)),
          ));
      print('Response data: ${response.body}');
    } else {
      // Request failed
      print('Failed to send SMS. Status code: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 43, 70, 62),
      body: Center(
        child: Column(
          // padding: const EdgeInsets.all(21),
          children: [
            SizedBox(
              height: 80,
            ),
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
              height: 10,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportNameController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    controller: _passportPasswordController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Gender:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportGenderController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Male/Female',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Passport Type:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportTypeController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter your passport type',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportNumberController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter your passport number',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Nationality:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportNationalityController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter your nationality',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Date of Issue:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportDoiController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter passport issue date',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Date of Expiry:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontFamily: "Brand-Bold",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: _passportDoeController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 175, 55))),
                      hintText: 'Enter passport expiry date',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 212, 175, 55),
                        fontFamily: "Brand-Bold",
                      ),
                    ),
                  ),
                ),
              ]),
            )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  final String name = _passportNameController.text;
                  final String password = _passportPasswordController.text;
                  final String gender = _passportGenderController.text;
                  final String passportType = _passportTypeController.text;
                  final String passportNumber = _passportNumberController.text;
                  final String nationality =
                      _passportNationalityController.text;
                  final String dateOfIssue = _passportDoiController.text;
                  final String dateOfExpiry = _passportDoeController.text;

                  SQLHelper.createUser(name, password, gender, passportType,
                      passportNumber, nationality, dateOfIssue, dateOfExpiry);
                  // sendSMSv1();
                  sendSMSv2();
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 212, 175, 55),
                ),
                child: const Text(
                  "Register",
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
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Brand-Regular",
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
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
