import 'package:koora_app/model/loacal_team.dart';

abstract class GlobalTeamStates {}

class GlobalTeamInitialState extends GlobalTeamStates {}

class GlobalTeamLoadingState extends GlobalTeamStates {}

class GlobalTeamSuccessState extends GlobalTeamStates {
  GlobalTeamSuccessState();
}

class GlobalTeamErrorState extends GlobalTeamStates {
  final String error;

  GlobalTeamErrorState(this.error);
}

class SelectGlobalLoadingState extends GlobalTeamStates {}

class SelectGlobalSuccessState extends GlobalTeamStates {}

class SelectGlobalErrorState extends GlobalTeamStates {
  final error;

  SelectGlobalErrorState(this.error);
}

class SuggestGlobalTeamLoadingState extends GlobalTeamStates {}

class SuggestGlobalTeamSuccessState extends GlobalTeamStates {}

class SuggestGlobalTeamErrorState extends GlobalTeamStates {
  final error;

  SuggestGlobalTeamErrorState(this.error);
}
