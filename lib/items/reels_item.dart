import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/verification_video.dart';
import 'package:koora_app/screens/bnb_screens/game_zone/add_comment_reels_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

import '../model/reels_model.dart';
import '../screens/bnb_screens/game_zone/commints_Rells_screen.dart';
import '../screens/bnb_screens/game_zone/cubit/cubit.dart';
import '../screens/bnb_screens/game_zone/cubit/state.dart';
import 'commint_item.dart';

class ReelsItem extends StatefulWidget {
  final String src;
  final Data4 reactions;
  const ReelsItem({Key key, this.src, this.reactions}) : super(key: key);

  @override
  _ReelsItemState createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  bool _liked = false;
  bool colorLike;
  dynamic countLike;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer();

    colorLike = widget.reactions.isLike;
    countLike = widget.reactions.reactionCounts;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.src);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  File _file;

  @override
  Widget build(BuildContext context) {
    var cubit = RellsCubit.get(context);

    Future<dynamic> uploadImage(File file) async {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "video": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      await cubit.postRells(videoSrc: formData);

      print(formData.toString());
    }

    return BlocConsumer<RellsCubit, RellsStates>(
      listener: (context, state) {
        if (state is PostLikeSuccessState) {
          setState(() {
            countLike = cubit.count;
            colorLike = !colorLike;
          });
        }
      },
      builder: (context, state) => Stack(
        children: [
          _chewieController != null &&
                  _chewieController.videoPlayerController.value.isInitialized
              ? GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _liked = !_liked;
                    });
                  },
                  child: Chewie(
                    controller: _chewieController,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: 10),
                    Center(child: Text('Loading...'))
                  ],
                ),

          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) *
                0.36,
            child: LayoutBuilder(
              builder: (ctx, constraint) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 30),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xffE6B700),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                    size: Size.fromRadius(22),
                                    child: Image.network(
                                      widget.reactions.user.image,
                                      fit: BoxFit.cover,
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        myEnglishText(
                          widget.reactions.user.name,
                          15,
                          FontWeight.bold,
                          Color(0xffE6B700),
                        ),
                        const SizedBox(
                          width: 130,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Spacer(),

          Positioned(
            bottom: -10.h,
            child: Align(
              child: Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                child: LayoutBuilder(
                  builder: (ctx, constraint) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                          left: 15,
                        ),
                        child: InkWell(
                          onTap: () async {
                            await ImagePicker()
                                .getVideo(source: ImageSource.gallery)
                                .then((value) {
                              setState(() {
                                _file = File(value.path);
                              });
                              To(context,
                                  VideoPlayerFileCustum(videopath: _file.path));
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 50.0.w,
                            height: 50.0.h,
                            decoration: const BoxDecoration(
                              color: Color(0xff3193BC),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              "assets/icons/add_commint_icon.png",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.68,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.postLike(real_id: widget.reactions.id);
                              setState(() {});

                              //like
                            },
                            child: Image.asset(
                              "assets/icons/reels_like_icon.png",
                              color: colorLike ? Colors.red : Colors.white,
                              height: constraint.maxHeight * 0.15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myArabicText(
                            countLike.toString(),
                            12,
                            FontWeight.bold,
                            Colors.white,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: CommintRellsScreen(
                                          widget.reactions.id,
                                          'reels',
                                          widget.reactions.user.image)));
                            },
                            child: Image.asset(
                              "assets/icons/comment_icon.png",
                              height: constraint.maxHeight * 0.15,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myArabicText(
                            "تعليق ${widget.reactions.commentsCount}",
                            10,
                            FontWeight.bold,
                            Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
