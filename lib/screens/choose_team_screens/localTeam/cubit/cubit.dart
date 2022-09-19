import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/model/loacal_team.dart';
import 'package:koora_app/screens/choose_team_screens/globalTeam/global_club_screen.dart';
import 'package:koora_app/screens/choose_team_screens/localTeam/cubit/state.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:koora_app/shared/end_points.dart';

import '../../../../model/suggestTeam.dart';
import '../../../bnb_screens/settings/edit_profile/edit_profile_screen.dart';

class LocalTeamCubit extends Cubit<LocalTeamStates> {
  LocalTeamCubit() : super(LocalTeamInitialState());

  static LocalTeamCubit get(context) => BlocProvider.of(context);
  Local_Teams local_team;

  dynamic articles = [];
  int lastpage;

  getLocalTeam({dynamic number = 1}) {
    emit(LocalTeamLoadingState());

    DioHelper.getData(
      url: 'local-teams?page=$number',
      token: token,
    ).then((value) {
      print(value.data.toString());
      local_team = Local_Teams.fromJson(value.data);
      lastpage = local_team.data.lastPage;
      articles.addAll(local_team.data.data);
      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      print('الصفحة الحاليييييييية');
      print(number);
      if (articles.isNotEmpty) {
        emit(LocalTeamSuccessState());
      }
    }).catchError((error) {
      printFullText(error.toString());
      emit(LocalTeamErrorState(error.toString()));
    });
  }

  SuggestTeam suggestTeam;

  void userSuggest({dynamic mydata, context}) {
    emit(SuggestTeamLoadingState());
    DioHelper.postData(token: token, url: SUGGEST, data: mydata).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      Fluttertoast.showToast(
          msg: "تم إقتراح الفريق سيتم مراجعة الطلب",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(SuggestTeamSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SuggestTeamErrorState(error.toString()));
    });
  }

  userTeamSelect({dynamic team_id, context}) {
    emit(LocalSelectLoadingState());
    DioHelper.postData(token: token, url: SELECTLOCAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      To(context, GlobalClubsScreen());

      emit(LocalSelecTeamSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LocalSelecTeamErrorState(error.toString()));
    });
  }

  userTeamSelectEdit({dynamic team_id, context}) {
    emit(LocalSelectLoadingState());
    DioHelper.postData(token: token, url: SELECTLOCAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      ToAndReplacment(context, EditeProfileScreen());

      emit(LocalSelecTeamSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LocalSelecTeamErrorState(error.toString()));
    });
  }
}
