abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates {}

class GetNotificationsLoadingState extends NotificationsStates {}

class GetNotificationsSuccessState extends NotificationsStates {
  GetNotificationsSuccessState();
}

class GetNotificationsErrorState extends NotificationsStates {
  final String error;

  GetNotificationsErrorState(this.error);
}
