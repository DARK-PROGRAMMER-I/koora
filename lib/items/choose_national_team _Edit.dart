import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/screens/choose_team_screens/almontakab.dart/cubit.dart';
import 'package:koora_app/screens/choose_team_screens/localTeam/cubit/cubit.dart';

import '../model/loacal_team.dart';

class ChooseNationalScreenItemEdit extends StatefulWidget {
  Data2 datateam;

  ChooseNationalScreenItemEdit(
    this.datateam,
  );

  @override
  _ChooseNationalScreenItemEditState createState() =>
      _ChooseNationalScreenItemEditState();
}

class _ChooseNationalScreenItemEditState
    extends State<ChooseNationalScreenItemEdit> {
  @override
  Widget build(BuildContext context) {
    var cubit = almontakhabTeamCubit.get(context);

    return InkWell(
      onTap: () {
        cubit.userNationalTeamSelectEdit(
            team_id: widget.datateam.id, context: context);
      },
      child: Stack(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.2,
            width: 120,
            decoration: BoxDecoration(
              color: Color(0xff283037),
              borderRadius: BorderRadius.circular(10),
            ),
            child: LayoutBuilder(
              builder: (ctx, constraint) => Column(
                children: [
                  Image.network(
                    "${widget.datateam.image}",
                    height: constraint.maxHeight * 0.8,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.02,
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.1,
                    width: 100,
                    child: Text(
                      "${widget.datateam.name}",
                      textAlign: TextAlign.center,
                      //                  overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'tajawal',
                      ),
                      //                    textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 3),
            child: Image.asset("assets/icons/star.png", width: 30),
          ),
        ],
      ),
    );
  }
}
