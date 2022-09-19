import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/choose_team_item.dart';
import 'package:koora_app/items/select_team_item.dart';
import 'package:koora_app/screens/bnb_screens/main_screen.dart';
import 'package:koora_app/screens/choose_team_screens/selectTeam/cubit.dart';
import 'package:koora_app/screens/choose_team_screens/selectTeam/state.dart';

import '../almontakab.dart/almontakhab_screen.dart';
import '../localTeam/cubit/cubit.dart';

class SelectedTeamScreen extends StatefulWidget {
  @override
  _SelectedTeamScreenState createState() => _SelectedTeamScreenState();
}

class _SelectedTeamScreenState extends State<SelectedTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SelectedTeamCubit()..getSelectedTeam(),
      child: BlocConsumer<SelectedTeamCubit, SelectedTeamStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var selectteamsuggest = SelectedTeamCubit.get(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Color(0xff20272D),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/icons/back_arrow.png",
                                  width: 10,
                                )),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      //

                      myArabicText(
                        "تهاني !",
                        20,
                        FontWeight.bold,
                        Color(0xffE6B700),
                      ),

                      myArabicText(
                        "الفرق الذي تم اختيارها",
                        20,
                        FontWeight.bold,
                        Colors.white,
                      ),

                      SizedBox(height: 15.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                ToAndFinish(context, MainScreen());
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    myArabicText(
                                      "التالي",
                                      15,
                                      FontWeight.normal,
                                      textColor,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: textColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: textColor,
                        indent: 20,
                        endIndent: 20,
                      ),

                      selectteamsuggest.myprofile != null
                          ? Container(
                              width: double.infinity,
                              height: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.7,
                              child: GridView.builder(
                                  //                    shrinkWrap: true,
                                  //                    physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.9,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                  ),
                                  // number of items in your list
                                  itemCount: selectteamsuggest
                                      .myprofile.data.teams.length,
                                  itemBuilder: (context, index) {
                                    return SelectedTeamScreenItem(
                                        selectteamsuggest
                                            .myprofile.data.teams[index]);
                                  }),
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
