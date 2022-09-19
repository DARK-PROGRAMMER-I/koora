import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/screens/bnb_screens/news/mynews.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/cubit.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/state.dart';
import 'package:koora_app/screens/bnb_screens/settings/setting/notifications/notifications_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/setting/setting_screen.dart';
import 'package:koora_app/shared/cache_helper.dart';
import 'package:koora_app/shared/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import '../../model/profile.dart';
import 'global_chat/globalchatscreen.dart';
import 'my_team_chat/my_team_chat_screen.dart';
import 'game_zone/game_zone_screen.dart';

const AndroidNotificationChannel channelNotification =
    AndroidNotificationChannel(
  '1', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 2;
  List<Teams> myTeam = [];

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      if (notification.title != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channelNotification.id,
              channelNotification.name,
              channelDescription: channelNotification.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher_round.png',
            ),
            iOS: IOSNotificationDetails(),
          ),
        );
      }
    });

    CacheHelper.saveData(key: 'token', value: token);
    // TODO: implement initState
    super.initState();
    initPusher();
    _pages = [
      {
        'page': MyTeamChatScreen(),
      },
      {
        'page': GlobalChatScreen(),
      },
      {
        'page': MyNews(),
      },
      {
        'page': GameZoneScreen(),
      },
      {
        'page': SettingScreen(),
      },
    ];
  }

  StreamController<String> _eventData = StreamController<String>();

  Channel channel;
  String channelName = 'chat';
  String eventName = 'message';
  Sink get _inEventData => _eventData.sink;

  Future<void> initPusher() async {
    await Pusher.init('d1e5c2ea08251da4d3a4', PusherOptions(cluster: 'ap1'));

    Pusher.connect(
      onConnectionStateChange: (p0) {
        print(p0.currentState);
      },
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  dynamic num = '0';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EditProfileCubit()..getProfileinfo(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                num = EditProfileCubit.get(context).numpoint;
                print(EditProfileCubit.get(context).numpoint);
                print('One second has passed.'); // Prints after 1 second.
              });
            });
          }
        },
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);

          //getProfileinfo

          return cubit.myprofile != null
              ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    backgroundColor: backGroundColors,
                    appBar: CostumAppBar(
                        func: () {
                          To(context, NotificationsScreen());
                        },
                        image: '${cubit.myprofile.data.image}',
                        number: num,
                        point: num),
                    body: Directionality(
                        textDirection: TextDirection.ltr,
                        child: _pages[_selectedPageIndex]['page'] as Widget),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: textColor, width: 0.3),
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Color(0xff21282F),
                        onTap: _selectPage,
                        currentIndex: _selectedPageIndex,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        selectedItemColor: textColor,
                        unselectedItemColor: Colors.grey,
                        selectedLabelStyle: const TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "tajawal",
                        ),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "tajawal",
                        ),
                        items: [
                          BottomNavigationBarItem(
                            icon: Image.asset("assets/icons/chat_icon.png",
                                color: _selectedPageIndex == 0
                                    ? textColor
                                    : Colors.grey),
                            label: "فريقي",
                            backgroundColor: const Color(0xff21282F),
                          ),
                          BottomNavigationBarItem(
                            icon: // Icon(Icons.home_outlined),
                                Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Image.asset(
                                  "assets/icons/global_chat_icon.png",
                                  color: _selectedPageIndex == 1
                                      ? textColor
                                      : Colors.grey),
                            ),
                            label: "العام",
                            backgroundColor: Color(0xff21282F),
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset("assets/icons/news_icon.png",
                                color: _selectedPageIndex == 2
                                    ? textColor
                                    : Colors.grey),
                            label: "الاخبار",
                            backgroundColor: Color(0xff21282F),
                          ),
                          BottomNavigationBarItem(
                            icon: // Icon(Icons.home_outlined),
                                Image.asset("assets/icons/gamezone_icon.png",
                                    color: _selectedPageIndex == 3
                                        ? textColor
                                        : Colors.grey),
                            label: "game zone",
                            backgroundColor: Color(0xff21282F),
                          ),
                          BottomNavigationBarItem(
                            icon: Image.asset("assets/icons/setting_icon.png",
                                color: _selectedPageIndex == 4
                                    ? textColor
                                    : Colors.grey),
                            label: "الاعدادات",
                            backgroundColor: Color(0xff21282F),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  // backgroundColor: Color.fromARGB(255, 25, 95, 153),
                  body: Center(
                  child: Lottie.asset('assets/lottiefiles/kora.json'),
                ));
        },
      ),
    );
  }
}
