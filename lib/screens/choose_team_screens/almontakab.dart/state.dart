import 'package:koora_app/model/loacal_team.dart';

abstract class almontakhabTeamStates {}

class almontakhabTeamInitialState extends almontakhabTeamStates {}

class almontakhabTeamLoadingState extends almontakhabTeamStates {}

class almontakhabTeamSuccessState extends almontakhabTeamStates {
  almontakhabTeamSuccessState();
}

class almontakhabTeamErrorState extends almontakhabTeamStates {
  final String error;

  almontakhabTeamErrorState(this.error);
}

class SelectNationalLoadingState extends almontakhabTeamStates {}

class SelectNationalSuccessState extends almontakhabTeamStates {}

class SelectNationalErrorState extends almontakhabTeamStates {
  final error;

  SelectNationalErrorState(this.error);
}

class SuggestalmontakhabTeamLoadingState extends almontakhabTeamStates {}

class SuggestalmontakhabTeamSuccessState extends almontakhabTeamStates {}

class SuggestalmontakhabTeamErrorState extends almontakhabTeamStates {
  final error;

  SuggestalmontakhabTeamErrorState(this.error);
}
