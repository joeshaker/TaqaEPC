import 'package:dropdown_button2/dropdown_button2.dart';
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
  String? selectedArea;
  String? selectedBranch;

  final TextEditingController areaSearchController = TextEditingController();
  final TextEditingController branchSearchController = TextEditingController();

  @override
  void dispose() {
    areaSearchController.dispose();
    branchSearchController.dispose();
    super.dispose();
  }

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

  List<String> areas = ['Area 1', 'Area 2', 'Area 3'];
  List<String> branches = ['Branch 1', 'Branch 2', 'Branch 3'];

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchArea = selectedArea == null || service['area'] == selectedArea;
      bool matchBranch = selectedBranch == null || service['branch'] == selectedBranch;
      return matchArea && matchBranch;
    }).toList();
  }

  void clearFilters() {
    setState(() {
      selectedArea = null;
      selectedBranch = null;
      areaSearchController.clear();
      branchSearchController.clear();
    });
  }

  void clearAreaFilter() {
    setState(() {
      selectedArea = null;
      areaSearchController.clear();
    });
  }

  void clearBranchFilter() {
    setState(() {
      selectedBranch = null;
      branchSearchController.clear();
    });
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
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Area Dropdown
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Area',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Row(
                          children: [
                            Icon(Icons.cleaning_services_rounded, color: Colors.black),
                            SizedBox(width: 8),
                          ],
                        ),
                        onTap: clearAreaFilter,
                      ),
                      ...areas
                          .where((area) => area.toLowerCase().contains(areaSearchController.text.toLowerCase()))
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                    ],
                    value: selectedArea,
                    onChanged: (value) {
                      setState(() {
                        selectedArea = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 200,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: areaSearchController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: areaSearchController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an area...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                      },
                    ),
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        areaSearchController.clear();
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                // Branch Dropdown
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Branch',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Row(
                          children: [
                            Icon(Icons.cleaning_services_rounded, color: Colors.black),
                            SizedBox(width: 8),
                          ],
                        ),
                        onTap: clearBranchFilter,
                      ),
                      ...branches
                          .where((branch) => branch.toLowerCase().contains(branchSearchController.text.toLowerCase()))
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                    ],
                    value: selectedBranch,
                    onChanged: (value) {
                      setState(() {
                        selectedBranch = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 200,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: branchSearchController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: branchSearchController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for a branch...',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                      },
                    ),
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        branchSearchController.clear();
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: clearFilters,
                      child: Text('Clear All Filters'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Change this to your desired color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 10),
                    // ElevatedButton(
                    //   onPressed: submitFilters,
                    //   child: Text('Apply Filters'),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue, // Change this to your desired color
                    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    //     textStyle: TextStyle(fontSize: 14),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildContainerService(
                        context, filteredServices[index]),
                    itemCount: filteredServices.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                  ),
                ),
              ],
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
