import '../../../../model/conversation_model.dart';

abstract class LocatTeamChatStates {}

class LocalTeamChatInitialState extends LocatTeamChatStates {}

class LocalTeamChatLoadingState extends LocatTeamChatStates {}

class LocalTeamChatSuccessState extends LocatTeamChatStates {
  LocalTeamChatSuccessState();
}

class LocalTeamChatErrorState extends LocatTeamChatStates {
  final String error;

  LocalTeamChatErrorState(this.error);
}

/////////////////////////////////////////////////////
///
class PostLocalTeamChatLoadingState extends LocatTeamChatStates {}

class PostLocalTeamChatSuccessState extends LocatTeamChatStates {}

class PostLocalTeamChatErrorState extends LocatTeamChatStates {
  final String error;

  PostLocalTeamChatErrorState(this.error);
}

////////////////////////almontakhab State//////////////////////
class almontakhabChatLoadingState extends LocatTeamChatStates {}

class almontakhabChatSuccessState extends LocatTeamChatStates {
  almontakhabChatSuccessState();
}

class almontakhabChatErrorState extends LocatTeamChatStates {
  final String error;

  almontakhabChatErrorState(this.error);
}

////////////////////post almontakhab ///////////////
class PostalmontakhabChatLoadingState extends LocatTeamChatStates {}

class PostalmontakhabChatSuccessState extends LocatTeamChatStates {}

class PostalmontakhabChatErrorState extends LocatTeamChatStates {
  final String error;

  PostalmontakhabChatErrorState(this.error);
}
