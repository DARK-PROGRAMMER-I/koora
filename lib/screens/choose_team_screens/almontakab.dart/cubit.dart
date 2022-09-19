import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/model/loacal_team.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/edit_profile_screen.dart';
import 'package:koora_app/screens/choose_team_screens/almontakab.dart/state.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:koora_app/shared/end_points.dart';

import '../../../components/global_componnets.dart';
import '../selectTeam/selected_team_screen.dart';

class almontakhabTeamCubit extends Cubit<almontakhabTeamStates> {
  almontakhabTeamCubit() : super(almontakhabTeamInitialState());

  static almontakhabTeamCubit get(context) => BlocProvider.of(context);

  dynamic almontakhab_team;

  List<dynamic> articles = [];
  int lastpage;

  getalmontakhabTeam({dynamic number = 1}) {
    emit(almontakhabTeamLoadingState());

    DioHelper.getData(
      url: 'national-teams?page=$number',
      token: token,
    ).then((value) {
      print(value.data.toString());
      almontakhab_team = Local_Teams.fromJson(value.data);
      articles.addAll(almontakhab_team.data.data);
      lastpage = almontakhab_team.data.lastPage;

      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }
      print('الصفحة الحاليييييييية');
      print(number);
      if (articles.isNotEmpty) {
        emit(almontakhabTeamSuccessState());
      }
    }).catchError((error) {
      printFullText(error.toString());
      emit(almontakhabTeamErrorState(error.toString()));
    });
  }

  void userNationalTeamSelect({dynamic team_id, context}) {
    emit(SelectNationalLoadingState());
    DioHelper.postData(token: token, url: SELECTNATIONAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      To(context, SelectedTeamScreen());

      emit(SelectNationalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SelectNationalErrorState(error.toString()));
    });
  }

  void userNationalTeamSelectEdit({dynamic team_id, context}) {
    emit(SelectNationalLoadingState());
    DioHelper.postData(token: token, url: SELECTNATIONAL, data: {
      'team_id': team_id,
    }).then((value) {
      print(value.data.toString());
      print('sucsess');

      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);
      ToAndReplacment(context, EditeProfileScreen());

      emit(SelectNationalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SelectNationalErrorState(error.toString()));
    });
  }

  void userSuggest({dynamic mydata, context}) {
    emit(SuggestalmontakhabTeamLoadingState());
    DioHelper.postData(token: token, url: SUGGEST, data: mydata).then((value) {
      print(value.data.toString());
      print('sucsess');
      Fluttertoast.showToast(
          msg: "تم إقتراح الفريق سيتم مراجعة الطلب",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      //  suggestTeam = SuggestTeam.fromJson(value.data);
      // print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data.token);

      emit(SuggestalmontakhabTeamSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SuggestalmontakhabTeamErrorState(error.toString()));
    });
  }
}
