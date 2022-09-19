import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:koora_app/screens/auth_screens/login_screen.dart';
import 'package:koora_app/screens/bnb_screens/main_screen.dart';
import 'package:koora_app/screens/notification_api.dart';
import 'package:koora_app/shared/bloc_observer.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:koora_app/shared/dio_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'shared/cache_helper.dart';

//  android and ios
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

// channel android
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  '1', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

//  Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // android
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  //ios
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NotificationApi.requestIOSPermissions();

  MobileAds.instance.initialize();

//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
////    systemNavigationBarColor: Colors.blue, // navigation bar color
//    statusBarColor: Colors.transparent, // status bar color
//
//  ));
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  //bool isDark>.....

  Widget widget;
  token = await CacheHelper.getData(key: 'token');
  userId = CacheHelper.getData(key: 'userId');
  if (token != null) {
    widget = MainScreen();
  } else {
    widget = LoginScreen();
  }
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  dynamic mywidget;

  MyApp(this.mywidget);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.orange,
          accentColor: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: mywidget,
      );
    });
  }
}
