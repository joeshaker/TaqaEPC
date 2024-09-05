import 'package:flutter/material.dart';
import 'package:taqa_epc/Shared/Component/Components.dart';
import 'package:taqa_epc/Shared/Constant/Colors/Color.dart';
import 'package:taqa_epc/modules/Login/LoginScreen.dart';
import 'package:taqa_epc/modules/ServiceDetails/ServiceDetail.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Set<String> selectedAreas = {};
  Set<String> selectedBranches = {};
  Set<String> selectedServices = {};
  String searchQuery = '';
  List<Map<String, dynamic>> services = [
    {"name": "Service 1", "area": "Area 1", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 1"},
    {"name": "Service 1", "area": "Area 1", "branch": "Branch 2", "date": DateTime.now(), "address": "Address 2"},
    {"name": "Service 1", "area": "Area 1", "branch": "Branch 3", "date": DateTime.now(), "address": "Address 3"},
    {"name": "Service 2", "area": "Area 1", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 1"},
    {"name": "Service 2", "area": "Area 2", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 2"},
    {"name": "Service 2", "area": "Area 3", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 3"},
    {"name": "Service 1", "area": "Area 2", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 1"},
    {"name": "Service 1", "area": "Area 3", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 2"},
    {"name": "Service 3", "area": "Area 1", "branch": "Branch 1", "date": DateTime.now(), "address": "Address 3"},
  ];

  List<Map<String, dynamic>> get filteredData {
    return services.where((service) {
      bool matchArea = selectedAreas.isEmpty || selectedAreas.contains(service['area']);
      bool matchBranch = selectedBranches.isEmpty || selectedBranches.contains(service['branch']);
      bool matchService = selectedServices.isEmpty || selectedServices.contains(service['name']);

      bool matchSearch = service['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          service['area']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          service['branch']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          service['address']!.toLowerCase().contains(searchQuery.toLowerCase());

      return matchArea && matchBranch && matchService && matchSearch;
    }).toList();
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
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Center(child: Text("Search by")),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        Column(
                          children: [
                            Row(
                              children: [
                                CustomCheckbox(
                                  label: "Area 1",
                                  isChecked: selectedAreas.contains("Area 1"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedAreas.add("Area 1");
                                      } else {
                                        selectedAreas.remove("Area 1");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Branch 1",
                                  isChecked: selectedBranches.contains("Branch 1"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedBranches.add("Branch 1");
                                      } else {
                                        selectedBranches.remove("Branch 1");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Service 1",
                                  isChecked: selectedServices.contains("Service 1"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedServices.add("Service 1");
                                      } else {
                                        selectedServices.remove("Service 1");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                CustomCheckbox(
                                  label: "Area 2",
                                  isChecked: selectedAreas.contains("Area 2"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedAreas.add("Area 2");
                                      } else {
                                        selectedAreas.remove("Area 2");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Branch 2",
                                  isChecked: selectedBranches.contains("Branch 2"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedBranches.add("Branch 2");
                                      } else {
                                        selectedBranches.remove("Branch 2");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Service 2",
                                  isChecked: selectedServices.contains("Service 2"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedServices.add("Service 2");
                                      } else {
                                        selectedServices.remove("Service 2");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                CustomCheckbox(
                                  label: "Area 3",
                                  isChecked: selectedAreas.contains("Area 3"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedAreas.add("Area 3");
                                      } else {
                                        selectedAreas.remove("Area 3");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Branch 3",
                                  isChecked: selectedBranches.contains("Branch 3"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedBranches.add("Branch 3");
                                      } else {
                                        selectedBranches.remove("Branch 3");
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                CustomCheckbox(
                                  label: "Service 3",
                                  isChecked: selectedServices.contains("Service 3"),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedServices.add("Service 3");
                                      } else {
                                        selectedServices.remove("Service 3");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: defaultTextFormDecorated(
                      hintColor: Colors.black,
                      labelColor: Colors.black,
                      controller: searchController,
                      label: "Search",
                      hintText: "Enter search term",
                      type: TextInputType.text,
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            searchQuery = value ?? '';
                          });
                        }
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Search field should not be empty";
                        }
                        return null;
                      },
                      onChange: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      suffixPressed: () {
                        if (formKey.currentState!.validate()) {
                          print("Form is valid");
                        }
                      },
                      suffixicon: Icons.search,
                      prefixicon: Icons.menu,
                      fillColor: color2,
                      borderRadius: 30,
                      // Customize border radius
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ServiceDetail()));
                        },
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildContainerService(context, filteredData[index]),
                          itemCount: filteredData.length,
                          separatorBuilder: (context, index) => SizedBox(height: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContainerService(BuildContext context, Map<String, dynamic> service) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color2,
      ),
      width: MediaQuery.of(context).size.width * 0.88,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(fit: BoxFit.scaleDown, child: Text(service['name'] ?? '')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.077,
                ),
                FittedBox(fit: BoxFit.scaleDown, child: Text(service['area'] ?? '')),
                FittedBox(fit: BoxFit.scaleDown, child: Text(service['branch'] ?? '')),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: Text(service['name'] ?? ''), fit: BoxFit.scaleDown),
                SizedBox(height: 20),
                FittedBox(fit: BoxFit.scaleDown, child: Text(service['date'].toLocal().toString())),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    "Customer Address:\n${service['address'] ?? ''}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
