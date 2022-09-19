import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/state.dart';

import '../../../../model/edit_profile.dart';
import '../../../../model/profile.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/dio_helper.dart';
import '../../../../shared/end_points.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditInitialState());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  profileModel myprofile;
  dynamic numpoint;
  getProfileinfo() {
    emit(ProfileLoadingState());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      //print(value.data.toString());
      print('1233');
      myprofile = profileModel.fromJson(value.data);
      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      //  print();
      print('this is point');
      numpoint = value.data['data']['points'];
      emit(ProfileSuccessState(value.data['data']['points']));
    }).catchError((error) {
      print(error);
      emit(ProfileErrorState());
    });
  }

  EditProfie editProfie;

  EditProfileinfo({dynamic mydata}) {
    emit(EditProfileLoadingState());

    DioHelper.postData(
      data: mydata,
      url: profile,
      token: token,
    ).then((value) {
      print(value.data);
      //   print(value.data.toString());

      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      // getProfileinfo();

      emit(EditProfileSuccessState());
    }).catchError((error) {
      emit(EditProfileErrorState());
    });
  }

  EditPassword({dynamic password, dynamic passwordConfirm}) {
    emit(EditPasswordLoadingState());

    DioHelper.postData(
      data: {'password': password, 'password_confirmation': passwordConfirm},
      url: 'update-password',
      token: token,
    ).then((value) {
      //   print(value.data.toString());

      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      Fluttertoast.showToast(
          msg: "تم تعديل البيانات بنجاح",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      getProfileinfo();

      emit(EditPasswordSuccessState());
    }).catchError((error) {
      emit(EditPasswordErrorState());
    });
  }
}
