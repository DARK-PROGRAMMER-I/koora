import 'package:flutter/material.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    var height =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff20272D),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff283037),
          centerTitle: true,
          title: myArabicText(
            "المساعدة",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height - height) * 0.07,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "الاسم",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        fontFamily: 'tajawal',
                      ),
                      filled: true,
                      fillColor: Color(0xff283037),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height - height) * 0.07,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "البريد الإلكتروني",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        fontFamily: 'tajawal',
                      ),
                      filled: true,
                      fillColor: Color(0xff283037),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "الرسالة",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      fontFamily: 'tajawal',
                    ),
                    filled: true,
                    fillColor: Color(0xff283037),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height:
                        (MediaQuery.of(context).size.height - height) * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: textColor,
                    ),
                    child: myArabicText(
                      "ارسل",
                      12,
                      FontWeight.bold,
                      Colors.white,
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
