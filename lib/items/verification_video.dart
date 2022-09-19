import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/screens/bnb_screens/game_zone/game_zone_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../screens/bnb_screens/game_zone/cubit/cubit.dart';
import '../screens/bnb_screens/game_zone/cubit/state.dart';

class VideoPlayerFileCustum extends StatefulWidget {
  VideoPlayerFileCustum({Key key, this.videopath}) : super(key: key);
  final String videopath;

  @override
  _VideoPlayerFileState createState() => _VideoPlayerFileState();
}

class _VideoPlayerFileState extends State<VideoPlayerFileCustum> {
  VideoPlayerController _controller;
  Future<void> _video;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videopath));
    _video = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RellsCubit()..getRells(),
      child: BlocConsumer<RellsCubit, RellsStates>(
        listener: (context, state) {
          if (state is PostRellsSuccessState) {
            Navigator.pop(context);
            //    ToAndFinish(context, GameZoneScreen());
          }
        },
        builder: (context, state) {
          var cubit = RellsCubit.get(context);

          Future<dynamic> uploadImage() async {
            String fileName = widget.videopath.split('/').last;
            FormData formData = FormData.fromMap({
              "video": await MultipartFile.fromFile(widget.videopath,
                  filename: fileName),
            });
            await cubit.postRells(videoSrc: formData);

            print(formData.toString());
          }

          return Scaffold(
            body: FutureBuilder(
              future: _video,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                      ConditionalBuilder(
                        condition: state is! PostRellsLoadingState,
                        builder: (context) => Container(
                            margin: EdgeInsets.only(bottom: 100.h),
                            alignment: Alignment.bottomCenter,
                            child: myButton('تأكيد', () {
                              uploadImage();
                            })),
                        fallback: (context) => Center(
                            child: Lottie.asset(
                                'assets/lottiefiles/waiting.json')),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_controller.value.isPlaying) {
                  setState(() {
                    _controller.pause();
                  });
                } else {
                  setState(() {
                    _controller.play();
                  });
                }
              },
              child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          );
        },
      ),
    );
  }
}
