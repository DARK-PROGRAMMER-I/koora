import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/choose_team_screens/selectTeam/state.dart';
import 'package:koora_app/shared/constants.dart';

import '../../../model/profile.dart';
import '../../../shared/dio_helper.dart';
import '../../../shared/end_points.dart';

class SelectedTeamCubit extends Cubit<SelectedTeamStates> {
  SelectedTeamCubit() : super(SelectedTeamInitialState());

  static SelectedTeamCubit get(context) => BlocProvider.of(context);
  profileModel myprofile;

  getSelectedTeam() {
    emit(SelectedTeamLoadingState());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      print(value.data.toString());
      myprofile = profileModel.fromJson(value.data);
      // for (int i = 0; i < articles.length; i++) {
      //   print(articles[i].name);
      // }

      emit(SelectedTeamSuccessState());
    }).catchError((error) {
      emit(SelectedTeamErrorState());
    });
  }
}
