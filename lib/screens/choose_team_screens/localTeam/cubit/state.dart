import 'package:koora_app/model/loacal_team.dart';

abstract class LocalTeamStates {}

class LocalTeamInitialState extends LocalTeamStates {}

class LocalTeamLoadingState extends LocalTeamStates {}

class LocalTeamSuccessState extends LocalTeamStates {
  LocalTeamSuccessState();
}

class LocalTeamErrorState extends LocalTeamStates {
  final String error;

  LocalTeamErrorState(this.error);
}

class SuggestTeamLoadingState extends LocalTeamStates {}

class SuggestTeamSuccessState extends LocalTeamStates {}

class SuggestTeamErrorState extends LocalTeamStates {
  final error;

  SuggestTeamErrorState(this.error);
}

class LocalSelectLoadingState extends LocalTeamStates {}

class LocalSelecTeamSuccessState extends LocalTeamStates {}

class LocalSelecTeamErrorState extends LocalTeamStates {
  final error;

  LocalSelecTeamErrorState(this.error);
}
