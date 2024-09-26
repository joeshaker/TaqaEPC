import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taqa_epc/Shared/Constant/Colors/Color.dart';
import 'package:taqa_epc/Shared/Constant/consts.dart';
import 'package:taqa_epc/Shared/network/local/cache_helper.dart';
import 'package:taqa_epc/modules/Login/Cubit/login_cubit.dart';
import 'package:taqa_epc/modules/Services/Services.dart';

import '../../Shared/Component/Components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final EmailController = TextEditingController();
  final PassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is LoginSuccess){
      if (state.loginmodel.status == true) { // Treat "true" as a string
        print(state.loginmodel.message);
        print(state.loginmodel.data!.token);
        ShowToast(text: '${state.loginmodel.message}', state: ToastStates.SUCCESS);
        CacheHelper.saveData(
            key: 'token',
            value: state.loginmodel.data!.token
        ).then((value) {
          token = state.loginmodel.data!.token;
          navigateAndFinish(context, ServiceScreen());
        }).catchError((error){
          if(state is LoginError){
            print(state.loginmodel.message);
          }
        });
      } else {
        print(state.loginmodel.message);
        ShowToast(text: '${state.loginmodel.message}', state: ToastStates.ERROR);
      }
    }
    if(state is LoginError){
      print(state.Error);
    }
  },
  builder: (context, state) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background 2.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: formKey, // Attach the formKey to the Form widget
                child: Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image:
                          const AssetImage("assets/images/taqaf 1.png"),
                      width: MediaQuery.of(context).size.width*.7,),
                      const SizedBox(height: 40),
                      Stack(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Customer Relation Management",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..color = Colors.black
                                  ..strokeWidth = 2,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Customer Relation Management",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      defaultTextForm(
                        controller: EmailController,
                        label: "Username",
                        hintText: "Enter your username",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            // Handle submission if needed
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Username should not be empty";
                          }
                          // final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                          // if (!emailRegex.hasMatch(value)) {
                          //   return "Enter a valid email address";
                          // }
                          // return null;
                        },
                        onChange: (value) {},
                        suffixPressed: () {},
                        suffixicon: Icons.person,
                      ),
                      const SizedBox(height: 30),
                      defaultTextForm(
                        controller: PassController,
                        label: "Password",
                        hintText: "Enter your Password",
                        type: TextInputType.visiblePassword,
                        isPassword: LoginCubit.get(context).isPassword,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(EmailController.text, PassController.text);
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Password should not be empty";
                          }
                          return null;
                        },
                        onChange: (value) {},
                        suffixPressed: LoginCubit.get(context).ChangeVisiblity,
                        suffixicon: LoginCubit.get(context).sufixx,
                      ),
                      const Row(
                        children: [
                          Spacer(),
                          Text(
                            "Forget Password",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFAD982F),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilderRec(
                        condition: state is! LoginLoading,
                        builder: (context)=>SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(EmailController.text, PassController.text);
                                // if(token!=null){
                                //   navigateAndFinish(context, ServiceScreen());
                                // }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const ServiceScreen()),
                                // );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.lerp(color1, color2, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: color1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        fallback:(context)=>Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  },
),
);
  }
}
