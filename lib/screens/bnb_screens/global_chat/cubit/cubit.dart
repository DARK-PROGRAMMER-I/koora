import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/bnb_screens/global_chat/cubit/state.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/dio_helper.dart';

class GlobalChatCubit extends Cubit<GlobalChatStates> {
  GlobalChatCubit() : super(GlobalChatInitialState());

  static GlobalChatCubit get(context) => BlocProvider.of(context);
  dynamic mymessagesGlobal = [];
  Future getGlobalChat({int number = 1}) {
    emit(GlobalChatLoadingState());

    DioHelper.getData(
      url: 'general-conversation?page=$number',
      token: token,
    ).then((value) async {
      await mymessagesGlobal.addAll(value.data['data']['data']);

      emit(GlobalChatSuccessState());
    }).catchError((error) {
      print(error);
      emit(GlobalChatErrorState(error.toString()));
    });
  }

////////////////////////// Post Global ////////////////////////////
  postGlobalTeamChat({dynamic data}) {
    emit(PostGlobalChatLoadingState());

    DioHelper.postData(
      data: data,
      url: 'general-conversation',
      token: token,
    ).then((value) {
      //   print(value.data.toString());

      emit(PostGlobalChatSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PostGlobalChatErrorState(error.toString()));
    });
  }
}
