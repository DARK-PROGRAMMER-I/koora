import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/model/profile.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/almontakhab_screen_Edit.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/local_club_screen_edit.dart';

import '../screens/bnb_screens/settings/edit_profile/global_club_screen_edit.dart';

class EditeMyTeamItem extends StatefulWidget {
  final Teams teams;
  final int index;

  EditeMyTeamItem(this.teams, this.index);
  @override
  _EditeMyTeamItemState createState() => _EditeMyTeamItemState();
}

class _EditeMyTeamItemState extends State<EditeMyTeamItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.index == 0) {
          To(context, LocalClubScreenEdit());
        } else if (widget.index == 1) {
          To(context, GlobalClubsScreenEdit());
        } else {
          To(context, AlmontakhabScreenEdit());
        }
      },
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.17,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xff283037),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.network(
                      "${widget.teams.image}",
                      height: 80.h,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${widget.teams.name}",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 3),
                child: Image.asset("assets/icons/star.png", width: 15),
              ),
            ],
          ),
          Positioned(
              left: 0, child: Image.asset("assets/icons/edite_icon.png")),
        ],
      ),
    );
  }
}
