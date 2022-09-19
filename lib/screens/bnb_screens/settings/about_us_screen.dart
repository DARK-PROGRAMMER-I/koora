import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';

class AboutUSScreen extends StatefulWidget {
  @override
  _AboutUSScreenState createState() => _AboutUSScreenState();
}

class _AboutUSScreenState extends State<AboutUSScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff20272D),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff283037),
          centerTitle: true,
          title: myArabicText(
            "من نحن",
            15,
            FontWeight.bold,
            Colors.white,
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icons/back_icon.png",
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //

                Image.asset("assets/images/logo.png"),
                SizedBox(height: 80),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff283037),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "  يُعد تطبيق Koora Zone  أحد أبسط التطبيقات التي يُمكنك من خلالها التواصل مع مشجعين فريقك ومع الخصوم الرياضة عن بُعد مع الأصدقاء عبر دردشة  مباشرةً على هاتفك.أفضل جزء هو سهولة استخدام التطبيق. ما عليك سوى دعوة صديق ،وتحديد فريقك المفضل ، وبدء المحادثة. ويمكن التواصل مع الخصوموبدء الدردشة والتحدي بينهم في دردشة العامة. وهناك صفحة خاصة بالاخبار يمكنك التفاعل مع الاخبار والتعليق ،ويمكن الطلب من المسؤول لسماح لك بالنشر في الاخبار العامة.",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  wordSpacing: 2,
                                  height: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'tajawal'),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "  يُعد تطبيق Koora Zone  أحد أبسط التطبيقات التي يُمكنك من خلالها التواصل مع مشجعين فريقك ومع الخصوم الرياضة عن بُعد مع الأصدقاء عبر دردشة  مباشرةً على هاتفك.أفضل جزء هو سهولة استخدام التطبيق. ما عليك سوى دعوة صديق ،وتحديد فريقك المفضل ، وبدء المحادثة. ويمكن التواصل مع الخصوموبدء الدردشة والتحدي بينهم في دردشة العامة. وهناك صفحة خاصة بالاخبار يمكنك التفاعل مع الاخبار والتعليق ،ويمكن الطلب من المسؤول لسماح لك بالنشر في الاخبار العامة.",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  wordSpacing: 2,
                                  height: 2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'tajawal'),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
