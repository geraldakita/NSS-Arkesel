import 'package:digital_passport/passportnumber_data.dart';
import 'package:digital_passport/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Visas extends StatefulWidget {
  const Visas({super.key});

  @override
  State<Visas> createState() => _VisasState();
}

class _VisasState extends State<Visas> {
  List<Map<String, dynamic>> _visas = [];
  bool _isLoading = true;

  final TextEditingController _visaCountryController = TextEditingController();
  final TextEditingController _visaTypeController = TextEditingController();
  final TextEditingController _visaExpiryController = TextEditingController();

  void _getVisas(int userId) async {
    final data = await SQLHelper.getVisas(userId);
    setState(() {
      _visas = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    SQLHelper.db();
    final dataClass = Provider.of<DataClass>(context, listen: false);
    _getVisas(dataClass.userid);
    print(dataClass.userid);
  }

  Future<void> _addItem() async {
    final dataClass = Provider.of<DataClass>(context, listen: false);
    await SQLHelper.createVisa(dataClass.userid, _visaCountryController.text,
        _visaTypeController.text, _visaExpiryController.text);

    _getVisas(dataClass.userid);
  }

  Future<void> _updateItem(int id) async {
    final dataClass = Provider.of<DataClass>(context, listen: false);
    await SQLHelper.updateVisa(id, _visaCountryController.text,
        _visaTypeController.text, _visaExpiryController.text);
    _getVisas(dataClass.userid);
  }

  void _deleteItem(int id) async {
    final dataClass = Provider.of<DataClass>(context, listen: false);
    await SQLHelper.deleteVisa(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a Visa!'),
    ));
    _getVisas(dataClass.userid);
  }

  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingVisa =
          _visas.firstWhere((element) => element['VisaID'] == id);
      _visaCountryController.text = existingVisa['VisaCountry'];
      _visaTypeController.text = existingVisa['VisaType'];
      _visaExpiryController.text = existingVisa['ExpiryDate'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _visaCountryController,
                    decoration: const InputDecoration(hintText: 'Visa Country'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _visaTypeController,
                    decoration: const InputDecoration(hintText: 'Visa Type'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _visaExpiryController,
                    decoration: const InputDecoration(hintText: 'Visa Expiry'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _visaCountryController.text = '';
                      _visaTypeController.text = '';
                      _visaExpiryController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 43, 70, 62),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
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
                Expanded(
                  child: Center(
                      child: ListView.builder(
                    itemCount: _visas.length,
                    itemBuilder: (context, index) => (Card(
                      color: const Color.fromARGB(255, 212, 175, 55),
                      margin: const EdgeInsets.all(15),
                      child: ListTile(
                        isThreeLine: true,
                        leading: const Icon(
                          Icons.credit_card,
                          color: Color.fromARGB(255, 43, 70, 62),
                        ),
                        title: Text(_visas[index]['VisaCountry']),
                        subtitle: Text(_visas[index]['VisaType'] +
                            "\n" +
                            _visas[index]['ExpiryDate']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _showForm(_visas[index]['VisaID']),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteItem(_visas[index]['VisaID']),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  )),
                ),
              ],
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.person_outline,
              color: Color.fromARGB(255, 212, 175, 55),
            ),
            onPressed: () => Navigator.pushNamed(context, '/bio'),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 212, 175, 55),
            ),
            onPressed: () => _showForm(null),
          ),
        ],
      ),
    );
  }
}
