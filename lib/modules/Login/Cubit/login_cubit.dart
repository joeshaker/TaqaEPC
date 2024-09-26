import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taqa_epc/Shared/network/remote/dio_helper.dart';
import 'package:taqa_epc/models/LoginModel.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=> BlocProvider.of(context);
  LoginDataModel ?loginModel;
  void userLogin(
      @required String email,
      @required String password,
      ){
    emit(LoginLoading());
    DioHelper.postData(url: "https://student.valuxapps.com/api/login", data: {
      'email':email,
      'password':password

    }).then((value){
      print(value.data);
      loginModel=LoginDataModel.fromJson(value.data);
      print(loginModel!.status);
      emit(LoginSuccess(loginModel!));
    }
    ).catchError((error){
      emit(LoginError(error.toString()));
    });
  }
  IconData sufixx=Icons.lock;
  bool isPassword=true;

  void ChangeVisiblity(){
    isPassword=!isPassword;
    sufixx=isPassword?Icons.lock:Icons.lock_open_rounded;
    emit(ChangePasswordVisibilityState());
  }
}
