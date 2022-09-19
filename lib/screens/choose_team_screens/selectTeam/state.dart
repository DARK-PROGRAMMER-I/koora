abstract class SelectedTeamStates {}

class SelectedTeamInitialState extends SelectedTeamStates {}

class SelectedTeamLoadingState extends SelectedTeamStates {}

class SelectedTeamSuccessState extends SelectedTeamStates {
  SelectedTeamSuccessState();
}

class SelectedTeamErrorState extends SelectedTeamStates {}
