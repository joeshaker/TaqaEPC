import 'package:flutter/material.dart';
import 'package:taqa_epc/Shared/Component/Components.dart';
import 'package:taqa_epc/Shared/Constant/Colors/Color.dart';
import 'package:taqa_epc/modules/Services/Services.dart';

class ServiceDetail extends StatefulWidget {
  const ServiceDetail({super.key});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  bool _isStarted = false; // State variable to manage start state
  bool _isCompleted = false; // State variable to manage checkbox state
  bool _isEnd = false; // State variable to manage end state
  bool _isCheckboxEnabled = false; // State variable to manage checkbox clickability
  bool _isSaveEnabled = false; // State variable to manage save button clickability

  var noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Service Name Details"),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.lerp(color1, color2, 1),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width * 1.7,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCard("Customer:", "Youssef shaker"),
                _buildCard("Mobile:", "01009667936"),
                _buildCard("TAQAID:", "123"),
                _buildCard("CRN:", "34576272"),
                _buildCard("Branch:", "Elastad"),
                _buildCard("Area:", "Tanta"),
                _buildCard("Service:", "Service 1"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: !_isStarted ? _startService : null,
                      child: Text("Start"),
                      // Removed color logic
                    ),
                    SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: (_isStarted && _isCompleted && !_isEnd) ? _endService : null,
                      child: Text("End"),
                      // Removed color logic
                    ),
                    SizedBox(width: 6),
                    Checkbox(
                      value: _isCompleted,
                      onChanged: _isStarted && !_isEnd
                          ? (value) {
                        setState(() {
                          _isCompleted = value ?? false;
                          // Enable or disable the End button based on checkbox state
                          if (_isCompleted) {
                            _isCheckboxEnabled = true;
                          } else {
                            _isCheckboxEnabled = false;
                          }
                        });
                      }
                          : null,
                    ),
                    Text(
                      "Is Completed",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Note",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: defaultTextFormDecorated(
                        fillColor: Colors.grey,
                        controller: noteController,
                        label: "",
                        hintText: "",
                        type: TextInputType.text,
                        onSubmit: (value) {},
                        validate: (value) {},
                        onChange: (value) {},
                        suffixPressed: () {},
                        suffixicon: Icons.note_alt_sharp,
                        prefixPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isSaveEnabled ? _save : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.save_outlined, color: Colors.green),
                          Text("Save"),
                        ],
                      ),
                      // Removed color logic
                    ),
                    SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: _cancel,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.cancel_outlined, color: Colors.green),
                          Text("Cancel"),
                        ],
                      ),
                      // Removed color logic
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String text, String text2) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      color: Color.lerp(color1, color2, 1.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20),
            Text(
              text2,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _startService() {
    setState(() {
      _isStarted = true;
      _isCheckboxEnabled = false; // Disable the checkbox initially
      _isSaveEnabled = false; // Disable Save button initially
    });
  }

  void _endService() {
    setState(() {
      _isEnd = true;
      _isCheckboxEnabled = false; // Disable the checkbox
      _isSaveEnabled = true; // Enable Save button
    });
  }

  void _save() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen()));
  }

  void _cancel() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen()));
  }
}
