// ignore_for_file: empty_constructor_bodies

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit/state.dart';
import 'package:koora_app/shared/dio_helper.dart';

import '../../../../model/conversation_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/end_points.dart';

class LocatTeamChatCubit extends Cubit<LocatTeamChatStates> {
  LocatTeamChatCubit() : super(LocalTeamChatInitialState());

  static LocatTeamChatCubit get(context) => BlocProvider.of(context);
  List<dynamic> mymessages = [];
  getLocatTeamChat({int number = 1}) {
    emit(LocalTeamChatLoadingState());

    DioHelper.getData(
      url: 'local-conversation?page=$number',
      token: token,
    ).then((value) async {
      await mymessages.addAll(value.data['data']['data']);
      print(mymessages.isNotEmpty);
      print('هل يوجد بيانات');

      emit(LocalTeamChatSuccessState());
    }).catchError((error) {
      print(error);
      emit(LocalTeamChatErrorState(error.toString()));
    });
  }

  postLocatTeamChat({dynamic data}) {
    emit(PostLocalTeamChatLoadingState());

    DioHelper.postData(
      data: data,
      url: LOCALCONVERSATION,
      token: token,
    ).then((value) {
      //   print(value.data.toString());

      emit(PostLocalTeamChatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LocalTeamChatErrorState(error.toString()));
    });
  }
  /////////////////get global////////////////////

  /////////////////get  ALMONTAKHAB////////////////////

  List<dynamic> mymessagesalmontakab = [];
  getalmontakabChat({int number = 1}) {
    emit(almontakhabChatLoadingState());

    DioHelper.getData(
      url: 'national-conversation?page=$number',
      token: token,
    ).then((value) async {
      await mymessagesalmontakab.addAll(value.data['data']['data']);

      emit(almontakhabChatSuccessState());
    }).catchError((error) {
      print(error);
      emit(almontakhabChatErrorState(error.toString()));
    });
  }

////////////////////////// Post  ALMONTAKHAB ////////////////////////////
  postalmontakabChat({dynamic data}) {
    emit(PostalmontakhabChatLoadingState());

    DioHelper.postData(
      data: data,
      url: ALMONTAKHABCONVERATION,
      token: token,
    ).then((value) {
      //   print(value.data.toString());

      emit(PostalmontakhabChatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostalmontakhabChatErrorState(error.toString()));
    });
  }
}
