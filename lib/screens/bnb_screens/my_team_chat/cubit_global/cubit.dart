// ignore_for_file: empty_constructor_bodies

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit/state.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit_global/state.dart';
import 'package:koora_app/shared/dio_helper.dart';

import '../../../../model/conversation_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/end_points.dart';

class GlobalTeamChatCubit extends Cubit<GlobalTeamChatStates> {
  GlobalTeamChatCubit() : super(GlobalTeamChatInitialState());

  static GlobalTeamChatCubit get(context) => BlocProvider.of(context);

  /////////////////get global////////////////////

  dynamic mymessagesGlobal = [];
  Future getGlobalTeamChat({int number = 1}) {
    emit(GlobalTeamChatLoadingState());

    DioHelper.getData(
      url: 'global-conversation?page=$number',
      token: token,
    ).then((value) async {
      await mymessagesGlobal.addAll(value.data['data']['data']);

      emit(GlobalTeamChatSuccessState());
    }).catchError((error) {
      print(error);
      emit(GlobalTeamChatErrorState(error.toString()));
    });
  }

////////////////////////// Post Global ////////////////////////////
  postGlobalTeamChat({dynamic data}) {
    emit(PostGlobalTeamChatLoadingState());

    DioHelper.postData(
      data: data,
      url: GLOBALCONVERATION,
      token: token,
    ).then((value) {
      //   print(value.data.toString());

      emit(PostGlobalTeamChatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostGlobalTeamChatErrorState(error.toString()));
    });
  }

  /////////////////get  ALMONTAKHAB////////////////////

}
