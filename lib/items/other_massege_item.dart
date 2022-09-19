import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/item.dart';

import '../model/conversation_model.dart';
import 'massege_with_image_item.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;

class OtherMassegeItem extends StatefulWidget {
  final mydata;

  OtherMassegeItem(this.mydata);
  @override
  _OtherMassegeItemState createState() => _OtherMassegeItemState();
}

class _OtherMassegeItemState extends State<OtherMassegeItem> {
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                Container(
                  //  width: MediaQuery.of(context).size.width * 0.6,
                  constraints: const BoxConstraints(
                    minHeight: 100.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color(0xff1A1A1A),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, bottom: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xffE6B700),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox.fromSize(
                                        size: Size.fromRadius(22),
                                        child: Image.network(
                                          "${widget.mydata['user']['image']}",
                                          fit: BoxFit.cover,
                                        ))),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            myEnglishText(
                              "${widget.mydata['user']['name']}",
                              11,
                              FontWeight.bold,
                              const Color(0xffE6B700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 330,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                          child: widget.mydata['message'] != null
                              ? Text(
                                  "${widget.mydata['message']}",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'tajawal'),
                                  textAlign: TextAlign.right,
                                )
                              : Container(
                                  child: Image.network(widget.mydata['image']),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 17,
              left: 10,
              child: Image.asset("assets/icons/other_part.png")),
          // const Positioned(
          //   bottom: 5,
          //   right: 70,
          //   //  child: Container(height: 30.h, child: Item(Example.reactions)),
          // ),
        ],
      ),
    );
  }
}
