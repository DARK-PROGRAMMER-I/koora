import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';



class AdsScreen extends StatefulWidget {

  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {



  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(

        backgroundColor: Color(0xff20272D),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff283037),
          centerTitle: true,
          title:   myArabicText(
            "لاعلاناتكم على التطبيق",
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 50,),




                Image.asset("assets/images/logo.png"),

                SizedBox(height: 50,),



                myArabicText(
                  "بامكانك التواصل معنا لاعلاناتكم بداخل التطبيق",
                  15,
                  FontWeight.bold,
                  Colors.white,
                ),

                SizedBox(height: 50,),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30).add(EdgeInsets.only(bottom: 10)),
                  child: Row(
                    children: [
                      Text(
                        "البريد الاكتروني",
                        style:  TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'tajawal'
                        ),
                        textAlign:  TextAlign.right,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: (MediaQuery.of(context).size.height -  height ) * 0.07,
                  child: TextField(
                    enabled: true,
                    onTap: () => FocusManager.instance.primaryFocus.unfocus(),

                    decoration: InputDecoration(
                      hintText: "koorazone92@gmail.com",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'lora',
                      ),
                      filled: true,
                      fillColor: Color(0xff283037),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                      prefixIcon: Image.asset("assets/icons/email.png" , color: Colors.grey,),
                    ),
                  ),
                ),


                SizedBox(height: 30,),



                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30).add(EdgeInsets.only(bottom: 10)),
                      child: Text(
                        "رقم الموبايل",
                        style:  TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'tajawal'
                        ),
                        textAlign:  TextAlign.right,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: (MediaQuery.of(context).size.height -  height ) * 0.07,
                  child: TextField(
                    enabled: true,
                    onTap: () => FocusManager.instance.primaryFocus.unfocus(),
                    decoration: InputDecoration(
                      hintText: "0096181265110",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'tajawal',
                      ),
                      filled: true,
                      fillColor: Color(0xff283037),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50)),
                      prefixIcon: Icon(Icons.phone_android_outlined , color: Colors.grey,),
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
