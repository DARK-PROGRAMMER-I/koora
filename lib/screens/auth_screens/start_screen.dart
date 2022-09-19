import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';

import 'signup_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backGroundColors,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 22.h),
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                child: Image.asset(
                  "assets/images/start_image.png",
                  width: 350,
                ),
              ),
              myEnglishText(
                "KoORa ZoNE",
                27,
                FontWeight.bold,
                textColor,
              ),
              SizedBox(
                height: 25.h,
              ),
              myArabicText(
                "تواصل مع مشجعين فريقك ومع الخصوم",
                19,
                FontWeight.normal,
                textColor,
              ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: myBorderButton(
                  myArabicText(
                    "بدء",
                    19,
                    FontWeight.normal,
                    textColor,
                  ),
                  () {
                    To(context, SignupScreen());
                  },
                ),
              ),
              Spacer(),
              myEnglishText(
                "AWK-software",
                20,
                FontWeight.bold,
                textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
