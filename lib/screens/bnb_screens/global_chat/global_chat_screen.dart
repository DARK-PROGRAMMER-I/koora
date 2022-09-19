import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/massege_with_image_item.dart';

import '../../../ad_mob/banner_ad.dart';

class GlobalChatScreen2 extends StatefulWidget {
  @override
  _GlobalChatScreen2State createState() => _GlobalChatScreen2State();
}

class _GlobalChatScreen2State extends State<GlobalChatScreen2> {
  @override
  Widget build(BuildContext context) {
    var height =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AdBanner("ca-app-pub-1206837523110524/1697130714"),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return MassegWithImageItem();
              }),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          width: 1.5,
                          color: textColor,
                        ),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1.5,
                          color: textColor,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: "نص الرسالة",
                      hintStyle: const TextStyle(
                        color: hintTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: 'tajawal',
                      ),
                      contentPadding: EdgeInsets.only(top: 10),
                      filled: true,
                      fillColor: textFieldColor,
                      // border: OutlineInputBorder(
                      //     borderSide: BorderSide.none,
                      //     borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: 20.0.w,
                            height: 20.0.h,
                            decoration: const BoxDecoration(
                              color: Color(0xff3193BC),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/icons/send_icon.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                  child: Image.asset(
                "assets/icons/cam_icon.png",
                width: 30,
              )),
              InkWell(
                  child: Image.asset(
                "assets/icons/image_icon.png",
                width: 50,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
