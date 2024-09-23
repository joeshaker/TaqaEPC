import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taqa_epc/modules/Login/LoginScreen.dart';
import 'package:taqa_epc/modules/ServiceDetails/ServiceDetail.dart';
import 'package:taqa_epc/modules/Services/Services.dart';
import 'package:dio/dio.dart';
import 'Shared/network/remote/dio_helper.dart';
// Import DioHelper class

void main() {
  // Initialize Dio
  DioHelper.init();

  // Initialize BlocObserver
  // Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
