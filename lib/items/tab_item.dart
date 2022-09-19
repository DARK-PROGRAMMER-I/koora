import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';

class TabItem extends StatefulWidget {
  dynamic image;
  String title;

  TabItem(this.image, this.title);

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          widget.image,
          height: 90.h,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18.sp,
                // color: color,
                fontWeight: FontWeight.w600,
                fontFamily: 'tajawal'),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
