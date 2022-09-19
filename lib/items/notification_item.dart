import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

import '../model/notifications_Model.dart';

class NotificationItem extends StatefulWidget {
  DataNotifications mydata;

  NotificationItem(this.mydata);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff283037),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "KoORa ZoNE",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: Color(0xffE6B700),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'lora'),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${widget.mydata.title}",
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'tajawal'),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
