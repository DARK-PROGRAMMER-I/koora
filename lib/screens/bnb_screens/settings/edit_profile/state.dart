import '../../../../model/profile.dart';

abstract class EditProfileStates {}

class EditInitialState extends EditProfileStates {}

class ProfileLoadingState extends EditProfileStates {}

class ProfileSuccessState extends EditProfileStates {
  String mypoint;

  ProfileSuccessState(mypoint);
}

class ProfileErrorState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccessState extends EditProfileStates {
  EditProfileSuccessState();
}

class EditProfileErrorState extends EditProfileStates {}

class EditPasswordLoadingState extends EditProfileStates {}

class EditPasswordSuccessState extends EditProfileStates {
  EditPasswordSuccessState();
}

class EditPasswordErrorState extends EditProfileStates {}
