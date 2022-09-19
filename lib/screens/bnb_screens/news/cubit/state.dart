import '../../../../model/postMode.dart';
import '../../../../model/voteModel.dart';

abstract class PostNewsStates {}

class PostNewsInitialState extends PostNewsStates {}

class PostNewsLoadingState extends PostNewsStates {}

class PostNewsSuccessState extends PostNewsStates {
  post_model mypost;

  PostNewsSuccessState(mypost);
}

class PostNewsErrorState extends PostNewsStates {
  final String error;

  PostNewsErrorState(this.error);
}

class GetCommentLoadingState extends PostNewsStates {}

class GetCommentSuccessState extends PostNewsStates {
  GetCommentSuccessState();
}

class GetCommentErrorState extends PostNewsStates {
  final String error;

  GetCommentErrorState(this.error);
}

class PostCommentLoadingState extends PostNewsStates {}

class PostCommentSuccessState extends PostNewsStates {
  PostCommentSuccessState();
}

class PostCommentErrorState extends PostNewsStates {
  final String error;

  PostCommentErrorState(this.error);
}

class PostVoiteLoadingState extends PostNewsStates {}

class PostVoiteSuccessState extends PostNewsStates {
  voiteModel voite;
  PostVoiteSuccessState(voite);
}

class PostVoiteErrorState extends PostNewsStates {
  final String error;

  PostVoiteErrorState(this.error);
}

class PostLikeLoadingState extends PostNewsStates {}

class PostLikeSuccessState extends PostNewsStates {
  PostLikeSuccessState();
}

class PostLikeErrorState extends PostNewsStates {
  final String error;

  PostLikeErrorState(this.error);
}
