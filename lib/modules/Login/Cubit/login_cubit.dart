import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taqa_epc/Shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=> BlocProvider.of(context);
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
      emit(LoginSuccess());
    }
    ).catchError((error){
      emit(LoginError(error.toString()));
    });
  }
}
