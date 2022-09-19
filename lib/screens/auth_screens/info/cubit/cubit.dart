import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/auth_screens/info/cubit/state.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:koora_app/shared/end_points.dart';

class InfoCubit extends Cubit<InfoStates> {
  InfoCubit() : super(InfoInitialState());

  static InfoCubit get(context) => BlocProvider.of(context);
  updateUserData({dynamic myinfo}) {
    emit(InfoLoadingHomeDataState());
    DioHelper.postData(
      url: UPDATE_PROFILE,
      token: token,
      data: myinfo,
    ).then((value) {
      print(myinfo);

      print(value.data);
      emit(InfoSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(InfoErrorHomeDataState(error.toString()));
    });
  }
}
