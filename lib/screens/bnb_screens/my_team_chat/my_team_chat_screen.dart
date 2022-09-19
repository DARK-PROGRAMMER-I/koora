import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/tab_item.dart';

import '../../../ad_mob/banner_ad.dart';
import '../settings/edit_profile/cubit.dart';
import 'almontakhab_chat_screen.dart';
import 'cubit/cubit.dart';
import 'global_club_chat_screen.dart';
import 'local_club_chat_screen.dart';

class MyTeamChatScreen extends StatefulWidget {
  @override
  _MyTeamChatScreenState createState() => _MyTeamChatScreenState();
}

class _MyTeamChatScreenState extends State<MyTeamChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    var cubit = EditProfileCubit.get(context);
    print('asddddddddddddddddddddd');
    print(cubit.myprofile.data.teams[0].image);

    return Scaffold(
      backgroundColor: backGroundColors,
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: backGroundColors,
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          To(
                            context,
                            LocalClubChatScreen(
                                cubit.myprofile.data.teams[0].id),
                          );
                        },
                        child: TabItem(
                          cubit.myprofile.data.teams[0].image,
                          "النادي المحلي",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          To(
                            context,
                            GlobalClubChatScreen(
                                cubit.myprofile.data.teams[1].id),
                          );
                        },
                        child: TabItem(
                          cubit.myprofile.data.teams[1].image,
                          "النادي العالمي",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          To(
                            context,
                            AlmontakhabChatScreen(
                                cubit.myprofile.data.teams[2].id),
                          );
                        },
                        child: TabItem(
                          cubit.myprofile.data.teams[2].image,
                          "المنتخب",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: Container(
                    child: AdBanner("ca-app-pub-1206837523110524/1697130714"),
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}



/*
 DefaultTabController(
          length: 3,
          child: Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        kBottomNavigationBarHeight) *
                    0.02,
              ),
              Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),
                  TabBar(
                    onTap: (value) {
                      print('on tab view');
                    },
                    unselectedLabelColor: Colors.white,
                    labelColor: textColor,
                    // indicatorColor:textColor,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2.0,
                      ),
                    ),

                    indicatorSize: TabBarIndicatorSize.tab,

                    tabs: [
                      InkWell(
                        child: TabItem(
                          cubit.myprofile.data.teams[0].image,
                          "النادي المحلي",
                        ),
                      ),
                      TabItem(
                        cubit.myprofile.data.teams[1].image,
                        "النادي العالمي",
                      ),
                      TabItem(
                        cubit.myprofile.data.teams[2].image,
                        "المنتخب",
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LocalClubChatScreen(),
                    GlobalClubChatScreen(),
                    AlmontakhabChatScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
 */