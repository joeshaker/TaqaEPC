import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taqa_epc/Shared/Component/Components.dart';
import 'package:taqa_epc/Shared/Constant/Colors/Color.dart';
import 'package:taqa_epc/Shared/network/local/cache_helper.dart';
import 'package:taqa_epc/modules/Login/Cubit/login_cubit.dart';
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
  String? selectedFilter; // To keep track of the selected filter criterion

  final TextEditingController searchController = TextEditingController(); // Unified search controller

  @override
  void dispose() {
    searchController.dispose(); // Dispose of the search controller
    super.dispose();
  }

  List<Map<String, dynamic>> services = [
    {"Customer name": "Ali shaker", "area": "Tanta", "branch": "Elastad", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Youssef shaker", "area": "cairo", "branch": "Maadi", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Ali shaker", "area": "Tanta", "branch": "Elastad", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Rodina Elgayar", "area": "Alex", "branch": "Smouha", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Mai mohammed", "area": "Tanta", "branch": "Elastad", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Farah shaker", "area": "Tanta", "branch": "Elastad", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Mai mohammed", "area": "Tanta", "branch": "Elastad", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Habiba Ahmed", "area": "Cairo", "branch": "Maadi", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Zeina hesham", "area": "Cairo", "branch": "Maadi", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Zeina hesham", "area": "Cairo", "branch": "Maadi", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Ahmed shaker", "area": "Alex", "branch": "Smouha", "date": DateTime.now(), "address": "21 osman street with sead "},
    {"Customer name": "Mohammed shaker", "area": "Cairo", "branch": "Maadi", "date": DateTime.now(), "address": "21 osman street with sead "},
  ];

  List<String> areas = ['Tanta', 'cairo', 'Alex'];
  List<String> branches = ['Elastad', 'Maadi', 'Smouha'];

  final formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> get filteredServices {
    return services.where((service) {
      bool matchArea = (selectedArea == null || service['area'] == selectedArea);
      bool matchBranch = (selectedBranch == null || service['branch'] == selectedBranch);

      bool matchSearch = searchController.text.isEmpty ||
          (selectedFilter == 'Area'
              ? service['area'].toLowerCase().contains(searchController.text.toLowerCase())
              : selectedFilter == 'Branch'
              ? service['branch'].toLowerCase().contains(searchController.text.toLowerCase())
              : selectedFilter == 'Customer Name'
              ? service['Customer name'].toLowerCase().contains(searchController.text.toLowerCase())
              : false);

      // Ensure that the service matches both area/branch and search term.
      return (selectedFilter == 'Area' && selectedArea != null
          ? matchArea
          : selectedFilter == 'Branch' && selectedBranch != null
          ? matchBranch
          : selectedFilter == 'Customer Name'
          ? matchSearch
          : matchArea && matchBranch) && matchSearch;
    }).toList();
  }


  void _showDropdownMenu(BuildContext context, List<String> items, ValueChanged<String?> onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .2,
          child: ListView(
            children: items.map((String item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  onSelected(item);
                  Navigator.pop(context); // Close the bottom sheet
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
      return Form(
        key: formKey,
        child: Stack(
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
                          CacheHelper.clearData(key: 'token').then((value){
                            if(value==true){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );

                            }
                          });
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => LoginScreen()),
                          // );
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
                    defaultTextFormDecorated(
                      controller: searchController,
                      label: '${selectedFilter ?? "Search"}',
                      hintText: "Search ${selectedFilter ?? ''}...",
                      type: TextInputType.text,
                      onSubmit: (value) {
                        setState(() {}); // Trigger filter when submitting search
                      },
                      validate: (value) {},
                      onChange: (value) {
                        setState(() {}); // Trigger filter when typing
                      },
                      suffixPressed: () {
                        // Optionally, clear the search input
                        searchController.clear();
                        setState(() {}); // Clear search and trigger filtering
                      },
                      suffixicon: Icons.search,
                      prefixicon: Icons.menu,
                      prefixPressed: () => _showDropdownMenu(
                        context,
                        ['Area', 'Branch', 'Customer Name'], // Dropdown items
                            (String? selected) {
                          setState(() {
                            selectedFilter = selected;
                            searchController.text = ''; // Clear the search text
                            if (selected == 'Area') {
                              Navigator.pop(context); // Close the filter dropdown menu
                              _showDropdownMenu(
                                context,
                                areas,
                                    (String? area) {
                                  setState(() {
                                    selectedArea = area;
                                    selectedBranch = null; // Clear branch selection when selecting area
                                  });
                                },
                              );
                            } else if (selected == 'Branch') {
                              Navigator.pop(context); // Close the filter dropdown menu
                              _showDropdownMenu(
                                context,
                                branches,
                                    (String? branch) {
                                  setState(() {
                                    selectedBranch = branch;
                                    selectedArea = null; // Clear area selection when selecting branch
                                  });
                                },
                              );
                            } else if (selected == 'Customer Name') {
                              selectedArea = null; // Clear area selection
                              selectedBranch = null; // Clear branch selection
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceDetail()));
                        },
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildContainerService(
                              context, filteredServices[index]),
                          itemCount: filteredServices.length,
                          separatorBuilder: (context, index) => SizedBox(height: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                FittedBox(fit: BoxFit.scaleDown, child: Text(service['Customer name'] ?? '')),
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
                FittedBox(child: Text(service['Customer name'] ?? ''), fit: BoxFit.scaleDown),
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
