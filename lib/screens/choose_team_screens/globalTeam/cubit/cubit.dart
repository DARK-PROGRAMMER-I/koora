import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/model/edit_profile.dart';
import 'package:koora_app/model/loacal_team.dart';
import 'package:koora_app/screens/choose_team_screens/almontakab.dart/almontakhab_screen.dart';
import 'package:koora_app/screens/choose_team_screens/globalTeam/cubit/state.dart';
import 'package:koora_app/screens/choose_team_screens/globalTeam/global_club_screen.dart';
import 'package:koora_app/screens/choose_team_screens/localTeam/cubit/state.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:koora_app/shared/end_points.dart';

import '../../../../components/global_componnets.dart';
import '../../../auth_screens/cubit/cubit.dart';
import '../../../bnb_screens/settings/edit_profile/edit_profile_screen.dart';

class GlobalTeamCubit extends Cubit<GlobalTeamStates> {
  GlobalTeamCubit() : super(GlobalTeamInitialState());

  static GlobalTeamCubit get(context) => BlocProvider.of(context);

  dynamic Global_team;

  List<dynamic> articles = [];
  int lastpage;

  getGlobalTeam({dynamic number = 1}) {
    emit(GlobalTeamLoadingState());

    DioHelper.getData(
      url: 'global-teams?page=$number',
      token: token,
    ).then((value) {
      print(value.data.toString());
      Global_team = Local_Teams.fromJson(value.data);
      articles.addAll(Global_team.data.data);
      lastpage = Global_team.data.lastPage;

      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      print('الصفحة الحاليييييييية');
      print(number);
      if (articles.isNotEmpty) {
        emit(GlobalTeamSuccessState());
      }
    }).catchError((error) {
      printFullText(error.toString());
      emit(GlobalTeamErrorState(error.toString()));
    });
  }

  void userGlobalTeamSelect({dynamic team_id, context}) {
    emit(SelectGlobalLoadingState());
    DioHelper.postData(token: token, url: SELECTGLOBAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      To(context, AlmontakhabScreen());

      emit(SelectGlobalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SelectGlobalErrorState(error.toString()));
    });
  }

  void userGlobalTeamSelectEdit({dynamic team_id, context}) {
    emit(SelectGlobalLoadingState());
    DioHelper.postData(token: token, url: SELECTGLOBAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      ToAndReplacment(context, EditeProfileScreen());

      emit(SelectGlobalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SelectGlobalErrorState(error.toString()));
    });
  }

  void userSuggest({dynamic mydata, context}) {
    emit(SuggestGlobalTeamLoadingState());
    DioHelper.postData(token: token, url: SUGGEST, data: mydata).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      Fluttertoast.showToast(
          msg: "تم إقتراح الفريق سوف يتم مراجعة الطلب",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);

      emit(SuggestGlobalTeamSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SuggestGlobalTeamErrorState(error.toString()));
    });
  }
}
