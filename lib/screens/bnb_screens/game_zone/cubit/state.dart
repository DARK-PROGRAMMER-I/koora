abstract class RellsStates {}

class RellsInitialState extends RellsStates {}

class RellsLoadingState extends RellsStates {}

class RellsSuccessState extends RellsStates {
  RellsSuccessState();
}

class RellsErrorState extends RellsStates {
  final String error;

  RellsErrorState(this.error);
}

class PostRellsLoadingState extends RellsStates {}

class PostRellsSuccessState extends RellsStates {
  PostRellsSuccessState();
}

class PostRellsErrorState extends RellsStates {
  final String error;

  PostRellsErrorState(this.error);
}

class PostLikeLoadingState extends RellsStates {}

class PostLikeSuccessState extends RellsStates {
  PostLikeSuccessState();
}

class PostLIkeErrorState extends RellsStates {
  final String error;

  PostLIkeErrorState(this.error);
}

class RellsCommentLoadingState extends RellsStates {}

class RellsCommentSuccessState extends RellsStates {
  RellsCommentSuccessState();
}

class RellsCommentErrorState extends RellsStates {
  final String error;

  RellsCommentErrorState(this.error);
}

class RellsPostCommentLoadingState extends RellsStates {}

class RellsPostCommentSuccessState extends RellsStates {
  RellsPostCommentSuccessState();
}

class RellsPostCommentErrorState extends RellsStates {
  final String error;

  RellsPostCommentErrorState(this.error);
}
