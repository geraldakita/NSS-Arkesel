import 'package:digital_passport/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_passport/passportnumber_data.dart';

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  List<Map<String, dynamic>> _details = [];
  bool _isLoading = true;

  void _getDetails(String passportNumber) async {
    final data = await SQLHelper.getUserDetails(passportNumber);
    setState(() {
      _details = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SQLHelper.db();
    final dataClass = Provider.of<DataClass>(context, listen: false);
    _getDetails(dataClass.number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 43, 70, 62),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                  const Text(
                    "Name:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontFamily: "Brand-Bold",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _details[0]["Name"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["Gender"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["PassportType"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["PassportNumber"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["Nationality"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["DateOfIssue"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
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
                  Text(
                    _details[0]["DateOfExpiry"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Brand-Regular",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final dataClass =
                            Provider.of<DataClass>(context, listen: false);
                        dataClass.changeUserId(_details[0]["UserID"]);

                        Navigator.pushNamed(context, '/visa');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 212, 175, 55),
                      ),
                      child: const Text(
                        "Visas",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 43, 70, 62),
                          fontFamily: "Brand-Bold",
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: "Brand-Bold",
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
