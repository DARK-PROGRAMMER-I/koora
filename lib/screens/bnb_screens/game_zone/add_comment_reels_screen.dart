import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/commint_item.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class AddCommentReelsScreen extends StatefulWidget {
  final int id;

  AddCommentReelsScreen(this.id);
  @override
  _AddCommentReelsScreenState createState() => _AddCommentReelsScreenState();
}

class _AddCommentReelsScreenState extends State<AddCommentReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RellsCubit(),
      child: BlocConsumer<RellsCubit, RellsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RellsCubit.get(context);

          return ConditionalBuilder(
            condition: state is! RellsCommentLoadingState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: backGroundColors,
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 15),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20)
                              .add(EdgeInsets.only(top: 30)),
                          child: ListView.builder(
                              //    itemCount: cubit.reels_model_comment.data.data.length,
                              itemBuilder: (context, index) {
                            //  return CommintItem();
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: textColor,
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox.fromSize(
                                        size: Size.fromRadius(22),
                                        child: Image.asset(
                                          "assets/images/avatar.jpg",
                                          fit: BoxFit.cover,
                                        ))),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: textColor,
                                      ),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: textColor,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    hintText: "نص الرسالة",
                                    hintStyle: TextStyle(
                                      color: hintTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      fontFamily: 'tajawal',
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(top: 20, right: 10),
                                    filled: true,
                                    fillColor: textFieldColor,
                                    // border: OutlineInputBorder(
                                    //     borderSide: BorderSide.none,
                                    //     borderRadius: BorderRadius.circular(10)),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: 20.0.w,
                                          height: 20.0.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xff3193BC),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                              "assets/icons/send_icon.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
