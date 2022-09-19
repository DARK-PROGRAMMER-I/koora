import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/item.dart';

import '../model/Message.dart';
import '../model/conversation_model.dart';
import 'massege_with_image_item.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;

class MyMassegeItem extends StatefulWidget {
  final mydata;

  MyMassegeItem(this.mydata);
  @override
  _MyMassegeItemState createState() => _MyMassegeItemState();
}

class _MyMassegeItemState extends State<MyMassegeItem> {
  double rating = 3;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xff24424E),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                          SizedBox(
                            width: 15,
                          ),
                          myEnglishText(
                            "${widget.mydata['user']['name']}",
                            11,
                            FontWeight.bold,
                            Color(0xffE6B700),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      width: 330,
                      child: Padding(
                          padding: EdgeInsets.only(
                              right: 10.w, bottom: 10.h, left: 10),
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
                                  // ignore: unnecessary_new
                                  constraints: new BoxConstraints(
                                      maxHeight: 250.0.h,
                                      maxWidth: double.infinity),
                                  child: Image.network(widget.mydata['image']),
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 11, right: 0, child: Image.asset("assets/icons/part.png")),
        /*   Positioned(
          bottom: 0,
          left: 90,
          child: Container(
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xff21282F),
                  width: 2,
                ),
                color: Color(0xff24424E),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: myEnglishText(
                      "2",
                      11,
                      FontWeight.bold,
                      Colors.white,
                    ),
                  ),
                 // Item(Example.reactions),
                ],
              )),
        ),*/
      ],
    );
  }
}
