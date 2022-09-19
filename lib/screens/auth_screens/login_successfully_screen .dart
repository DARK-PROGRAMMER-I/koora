import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import '../../components/global_componnets.dart';
import 'login_screen.dart';

class LoginSuccessfulyScreen extends StatefulWidget {
  @override
  _LoginSuccessfulyScreenState createState() => _LoginSuccessfulyScreenState();
}

class _LoginSuccessfulyScreenState extends State<LoginSuccessfulyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21282F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/check-mark.png",
              color: Colors.white,
              height: 150.h,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "تم التسجيل بنجاح",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'tajawal'),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "يُرجى مراجعة البريد الإلكتروني   ",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'tajawal'),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 30,
            ),
            myButton(
              "الرجوع لتسجيل الدخول",
              () {
                To(context, LoginScreen());
                //  To(context, InformationScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
