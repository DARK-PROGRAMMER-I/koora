import '../../../../model/conversation_model.dart';

abstract class GlobalTeamChatStates {}

class GlobalTeamChatInitialState extends GlobalTeamChatStates {}

////////////////////////Global State//////////////////////
class GlobalTeamChatLoadingState extends GlobalTeamChatStates {}

class GlobalTeamChatSuccessState extends GlobalTeamChatStates {
  GlobalTeamChatSuccessState();
}

class GlobalTeamChatErrorState extends GlobalTeamChatStates {
  final String error;

  GlobalTeamChatErrorState(this.error);
}

////////////////////post Global ///////////////
class PostGlobalTeamChatLoadingState extends GlobalTeamChatStates {}

class PostGlobalTeamChatSuccessState extends GlobalTeamChatStates {}

class PostGlobalTeamChatErrorState extends GlobalTeamChatStates {
  final String error;

  PostGlobalTeamChatErrorState(this.error);
}

////////////////////////almontakhab State//////////////////////
