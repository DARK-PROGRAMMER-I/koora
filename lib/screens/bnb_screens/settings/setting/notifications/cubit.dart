import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koora_app/screens/bnb_screens/settings/setting/notifications/state.dart';

import '../../../../../model/notifications_Model.dart';
import '../../../../../shared/constants.dart';
import '../../../../../shared/dio_helper.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitialState());

  static NotificationsCubit get(context) => BlocProvider.of(context);
  notifications_Model mynotifications;
  List<dynamic> postdata = [];
  List<DataNotifications> mynotifications2 = [];

  getNotifications({int number = 1}) {
    emit(GetNotificationsLoadingState());

    DioHelper.getData(
      url: 'notifications?page=$number',
      token: token,
    ).then((value) async {
      // mypost = post_model.fromJson(value.data);
      // print(mypost.data.data[0].details);
      mynotifications = notifications_Model.fromJson(value.data);
      mynotifications2.addAll(mynotifications.data.data);
      //   print(mypost.data.data[0].details);
      //  print(postdata);
      print(mynotifications.data.data[0].title);
      Timer(Duration(seconds: 1), () {
        emit(GetNotificationsSuccessState());
      });
    }).catchError((error) {
      print(error);
      emit(GetNotificationsErrorState(error.toString()));
    });
  }
}
