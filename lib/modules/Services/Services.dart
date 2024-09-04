import 'package:flutter/material.dart';
import 'package:taqa_epc/Shared/Component/Components.dart';
import 'package:taqa_epc/modules/Login/LoginScreen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedCategory = "cat1"; // Default to one of the categories defined

  // Define the items for the dropdown
  final List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(value: "cat1", child: Text("Company")),
    DropdownMenuItem(value: "cat2", child: Text("Service")),
    DropdownMenuItem(value: "cat3", child: Text("Branch")),
  ];

  // Method to handle the dropdown selection
  void _onDropdownChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedCategory = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background 2.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            leading: Image(image: AssetImage("assets/images/taqaf 1 (3).png")),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                    child: Icon(Icons.logout, size: 30)),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0, // Optional: Remove shadow for transparency
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .3, // Set the width of the dropdown button
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color of dropdown button
                              border: Border.all(color: Colors.black38, width: 2), // Border of dropdown button
                              borderRadius: BorderRadius.circular(10), // Border radius of dropdown button
                              boxShadow: <BoxShadow>[ // Apply shadow on Dropdown button
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.57), // Shadow for button
                                  blurRadius: 2, // Blur radius of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: DropdownButton<String>(
                                value: selectedCategory, // Ensure this matches one of the item values
                                items: items,
                                onChanged: _onDropdownChanged,
                                icon: Padding(
                                  padding: EdgeInsets.only(left: 15), // Adjust icon padding
                                  child: Icon(Icons.arrow_drop_down, color: Colors.grey), // Set icon color
                                ),
                                iconEnabledColor: Colors.grey, // Icon color
                                style: TextStyle(
                                  color: Colors.grey, // Text color
                                  fontSize: 15, // Font size on dropdown button (smaller)
                                  fontWeight: FontWeight.bold, // Font weight
                                ),
                                dropdownColor: Colors.white, // Dropdown background color
                                underline: SizedBox(), // Remove underline
                                isExpanded: true, // Make true to make width 100%
                                isDense: true, // Reduces the height of the dropdown button
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: defaultTextForm(
                          controller: searchController,
                          label: "Search",
                          hintText: "",
                          type: TextInputType.text,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              // Handle submission if needed
                            }
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Search field should not be empty";
                            }
                            return null;
                          },
                          onChange: (value) {},
                          suffixPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("Form is valid");
                            }
                          },
                          suffixicon: Icons.search,
                        ),
                      ),
                    ],
                  ),
                  // Add more widgets here
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
