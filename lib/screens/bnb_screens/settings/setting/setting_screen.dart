import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/item.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;
import 'package:koora_app/screens/auth_screens/login_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/about_us_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/ads_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/edit_profile_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/help_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/setting/notifications/notifications_screen.dart';
import 'package:koora_app/shared/constants.dart';

import '../../../../shared/cache_helper.dart';
import '../edit_profile/cubit.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                CostumAppBar().preferredSize.height) *
            0.90,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: LayoutBuilder(
          builder: (ctx, constraint) => Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  myArabicText(
                      "إعدادات  ", 11, FontWeight.normal, Colors.white),
                  myEnglishText(
                      'KoORa ZoNE', 11, FontWeight.normal, Colors.white)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  To(context, EditeProfileScreen());
                },
                child: Container(
                    height: constraint.maxHeight * 0.08,
                    child: myCardSetting(
                        'assets/icons/profile.png', 'الملف الشخصي')),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  To(context, NotificationsScreen());
                },
                child: Container(
                    height: constraint.maxHeight * 0.08,
                    child: myCardSetting('assets/icons/s2.png', 'الإشعارات')),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  To(context, HelpScreen());
                },
                child: Container(
                    height: constraint.maxHeight * 0.08,
                    child: myCardSetting('assets/icons/s5.png', 'مساعدة')),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  To(context, AboutUSScreen());
                },
                child: Container(
                    height: constraint.maxHeight * 0.08,
                    child: myCardSetting('assets/icons/s6.png', 'من نحن')),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  To(context, AdsScreen());
                },
                child: Container(
                    height: constraint.maxHeight * 0.08,
                    child: myCardSetting(
                        'assets/icons/s7.png', 'لاعلاناتكم على التطبيق')),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  ToAndFinish(context, LoginScreen());
                  token = null;
                  CacheHelper.removeData(key: 'token');
                  CacheHelper.removeData(key: 'userId');
                },
                child: Container(
                  height: constraint.maxHeight * 0.08,
                  child: Container(
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 20,
                          ),
                          SizedBox(
                            width: 22.w,
                          ),
                          myArabicText('تسجيل الخروج', 14, FontWeight.normal,
                              Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
