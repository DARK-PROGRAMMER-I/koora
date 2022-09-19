import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/item.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;

import '../model/comment.dart';

class CommintItem extends StatefulWidget {
  dynamic mycomment;

  CommintItem(this.mycomment);
  @override
  _CommintItemState createState() => _CommintItemState();
}

class _CommintItemState extends State<CommintItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                //padding: EdgeInsets.only(right: 20.h),
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                        NetworkImage(widget.mycomment['user']['image']),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: backGroundColors,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // height: 80.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              myEnglishText(widget.mycomment['user']['name'],
                                  15, FontWeight.w400, Colors.blue),
                              SizedBox(
                                height: 8.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: myArabicText(widget.mycomment['comment'],
                                    11, FontWeight.normal, Colors.white),
                              ),
                            ],
                          ),
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
