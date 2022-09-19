import 'package:flutter/material.dart';
import 'package:koora_app/model/login_models.dart';
import 'package:koora_app/model/register_models.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final loginModel;

  LoginSuccessState({this.loginModel});
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends LoginStates {}

////////////////////////////////////////////////////////

class RegisterInitialState extends LoginStates {}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {
  final RegisterModel registermodel;

  RegisterSuccessState(this.registermodel);
}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends LoginStates {}

class ForgetPasswordLoadingState extends LoginStates {}

class ForgetPasswordSuccessState extends LoginStates {
  ForgetPasswordSuccessState();
}

class ForgetPasswordErrorState extends LoginStates {
  final String error;

  ForgetPasswordErrorState(this.error);
}

class LoginSuccessGoogleState extends LoginStates {}
