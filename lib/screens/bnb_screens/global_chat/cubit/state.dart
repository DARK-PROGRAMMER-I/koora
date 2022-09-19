abstract class GlobalChatStates {}

class GlobalChatInitialState extends GlobalChatStates {}

////////////////////////Global State//////////////////////
class GlobalChatLoadingState extends GlobalChatStates {}

class GlobalChatSuccessState extends GlobalChatStates {
  GlobalChatSuccessState();
}

class GlobalChatErrorState extends GlobalChatStates {
  final String error;

  GlobalChatErrorState(this.error);
}

////////////////////post Global ///////////////
class PostGlobalChatLoadingState extends GlobalChatStates {}

class PostGlobalChatSuccessState extends GlobalChatStates {}

class PostGlobalChatErrorState extends GlobalChatStates {
  final String error;

  PostGlobalChatErrorState(this.error);
}
