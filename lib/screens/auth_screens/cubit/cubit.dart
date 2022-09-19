import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/model/login_models.dart';
import 'package:koora_app/model/register_models.dart';
import 'package:koora_app/screens/auth_screens/cubit/states.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:koora_app/shared/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel;
  userLogin(
      {@required String email, @required String password, @required context}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
      'device_name': "device_name",
    }).then((value) {
      print(value.data);
      print(value.data['message']);
      print('sucsess');

      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      Fluttertoast.showToast(
          msg: "${LoginCubit.get(context).loginModel.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  userLoginWithFacebook(
      {@required String provider,
      @required String access_token,
      @required context,
      @required String device_token}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'social_login', data: {
      'provider': provider,
      'access_token': access_token,
      'device_token': device_token,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      Fluttertoast.showToast(
          msg: "${LoginCubit.get(context).loginModel.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  userLoginWithGoogle(
      {@required String provider,
      @required String access_token,
      @required context,
      @required String device_token,
      @required email,
      @required id,
      @required image,
      @required name}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'social_login', data: {
      'email': email,
      'provider': provider,
      'id': id,
      'image': image,
      'name': name,
      'access_token': access_token,
      'device_token': device_token,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);
      print('this is value ');
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      Fluttertoast.showToast(
          msg: "تم تسجيل الدخول بنجاح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginSuccessState(loginModel: loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  // IconData suffix = Icons.visibility_outlined;
  // bool isPassword = true;

  // void changePasswordVisibility() {
  //   isPassword = !isPassword;
  //   suffix =
  //       isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  //   emit(ShopChangePasswordVisibilityState());
  // }

  RegisterModel registerModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String password_confirmation,
    @required String deviceToken,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'device_token': deviceToken,
    }).then((value) {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);

      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void ForgetPassword({
    @required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    DioHelper.postData(url: 'reset-password', data: {
      'email': email,
    }).then((value) {
      Fluttertoast.showToast(
          msg: "${value.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(ForgetPasswordSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }
}
