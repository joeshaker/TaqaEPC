import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taqa_epc/Shared/Constant/consts.dart';
import 'package:taqa_epc/modules/Login/LoginScreen.dart';
import 'package:taqa_epc/modules/ServiceDetails/ServiceDetail.dart';
import 'package:taqa_epc/modules/Services/Services.dart';
import 'package:dio/dio.dart';
import 'Shared/network/local/cache_helper.dart';
import 'Shared/network/remote/dio_helper.dart';
// Import DioHelper class

void main() async {
  // Initialize Dio
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  token=CacheHelper.getData(key: 'token');
  if(token!=null) widget=ServiceScreen();
  else widget=LoginScreen();

  // Initialize BlocObserver
  // Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key,required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: startWidget,
    );
  }
}
