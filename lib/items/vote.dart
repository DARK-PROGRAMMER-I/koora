import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/items/reactions.dart';
import 'package:koora_app/model/postMode.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;
import 'package:page_transition/page_transition.dart';

import '../components/global_componnets.dart';
import '../reaction/example_data.dart';
import '../reaction/item.dart';
import '../screens/bnb_screens/news/commints_screen.dart';
import '../screens/bnb_screens/news/cubit/cubit.dart';
import '../screens/bnb_screens/news/cubit/state.dart';
import '../screens/bnb_screens/settings/edit_profile/cubit.dart';
import 'best_safqa.dart';

class voite extends StatefulWidget {
  Data3 postdata;

  voite(this.postdata);

  @override
  State<voite> createState() => _voiteState();
}

class _voiteState extends State<voite> {
  bool colorLike;
  dynamic countLike;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorLike = widget.postdata.isLike;
    countLike = widget.postdata.reactionCounts;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
    var commentText = TextEditingController();
    var cubitProfile = EditProfileCubit.get(context);

    return BlocConsumer<NewsCubit, PostNewsStates>(
      listener: (context, state) {
        if (state is PostCommentSuccessState) {
          Future.delayed(const Duration(seconds: 2), () {
            cubitProfile.getProfileinfo();
          });
        }
        if (state is PostLikeSuccessState) {
          setState(() {
            countLike = cubit.count;
            colorLike = !colorLike;
            //print(state.post.data.data[widget.index].isLike);
          });
          // print(cubit.likeforpost.data.data[widget.index].reactionCounts);
          print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        }
      },
      builder: (context, state) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  myEnglishText(
                    "KoORa ZoNE",
                    13,
                    FontWeight.bold,
                    Colors.amber,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  myArabicText('${widget.postdata.details}', 16,
                      FontWeight.bold, Colors.white),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 200.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.postdata.options.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: safqa(widget.postdata.options[index], index),
                          );
                        }),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 0,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.LikePost(post_id: widget.postdata.id);
                                    //   setState(() {});
                                  },
                                  child: Container(
                                    height: 30.h,
                                    child: Image.asset(
                                        'assets/icons/reels_like_icon.png',
                                        color: colorLike
                                            ? Colors.red
                                            : Colors.white),
                                    //  child: Icon(Icons.),
                                    // child: Item(
                                    //     Example.reactions,
                                    //     Reaction<String>(
                                    //         value: null,
                                    //         icon: buildReactionsPreviewIcon(
                                    //             'assets/images/like.png')))
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                myArabicText(countLike.toString(), 15,
                                    FontWeight.normal, Colors.white),
                              ],
                            ),
                          ),
                          //         Container(height: 30.h, child: Item(Example.reactions)),
                          // Spacer(),
                          // Spacer(),

                          Expanded(
                            flex: 0,
                            child: InkWell(
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (context) => CommintScreen(
                                        widget.postdata.id,
                                        'post',
                                        cubitProfile.myprofile.data.image,
                                        cubitProfile));
                              },
                              child: Container(
                                  height: 30.h,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.comment_outlined,
                                        color: Colors.grey.shade600,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      //if (postdata.reactionCounts != 0)
                                      myArabicText(
                                          '${widget.postdata.commentsCount} تعليق',
                                          14,
                                          FontWeight.normal,
                                          Colors.white.withOpacity(0.4)),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.5),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      myArabicText('', 12, FontWeight.w100, Colors.white)
                    ],
                  ),
                  if (widget.postdata.comment != null)
                    Container(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //padding: EdgeInsets.only(right: 20.h),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox.fromSize(
                                      size: Size.fromRadius(22),
                                      child: Image.network(
                                        '${widget.postdata.comment.user.image}',
                                        fit: BoxFit.cover,
                                      ))),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: backGroundColors,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 80.h,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        myEnglishText(
                                            '${widget.postdata.comment.user.name}',
                                            15,
                                            FontWeight.w400,
                                            Colors.blue),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        myArabicText(
                                            '${widget.postdata.comment.comment}',
                                            11,
                                            FontWeight.normal,
                                            Colors.white),
                                      ],
                                    ),
                                  )),
                            ],
                          ))
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
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
                                  child: Image.network(
                                    cubitProfile.myprofile.data.image,
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: commentText,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
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
                                  onTap: () async {
                                    await cubit.postComment(
                                        comment: commentText.text,
                                        postId: widget.postdata.id,
                                        type: 'post');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20.0.w,
                                    height: 20.0.h,
                                    decoration: const BoxDecoration(
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
                ],
              ),
            ),
          )),
    );
  }
}
