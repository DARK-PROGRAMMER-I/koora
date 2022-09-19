abstract class InfoStates {}

class InfoInitialState extends InfoStates {}

class InfoLoadingHomeDataState extends InfoStates {}

class InfoSuccessHomeDataState extends InfoStates {}

class InfoErrorHomeDataState extends InfoStates {
  final error;

  InfoErrorHomeDataState(this.error);
}
