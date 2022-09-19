import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

//  android and ios
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String>();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
  );

  static void requestIOSPermissions() {
    if (Platform.isIOS) {
      _notification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static const InboxStyleInformation _inboxStyleInformation =
      InboxStyleInformation(
    ['mohammed', 'khaled', 'alseqaly'], //listMessages
    contentTitle: '3 messages', //dynamic
    summaryText: 'janedoe@example.com', // gmail
  );

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        enableVibration: false,
      ),
      iOS: const IOSNotificationDetails(),
    );
  }

  Future initNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions();
  }

  static Future init() async {
    NotificationAppLaunchDetails details =
        await _notification.getNotificationAppLaunchDetails();

    // when app is closed
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.payload);
    }

    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings ios = const IOSInitializationSettings();

    InitializationSettings settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    _notification.initialize(settings, onSelectNotification: (String paylod) {
      onNotification.add(paylod);
    });
  }

  static Future showNotification({
    int id = 0,
    String title,
    String body,
  }) async {
    _notification.show(
      id,
      title,
      body,
      await _notificationDetails(),
    );
  }

  Future cancelNotificationById(int id) async {
    await _notification.cancel(id);
  }

  Future cancelAllNotification() async {
    await _notification.cancelAll();
  }
}
