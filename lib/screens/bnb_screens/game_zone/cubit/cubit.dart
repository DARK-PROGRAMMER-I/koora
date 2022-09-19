import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/screens/bnb_screens/game_zone/cubit/state.dart';

import '../../../../model/comment.dart';
import '../../../../model/reels_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/dio_helper.dart';

class RellsCubit extends Cubit<RellsStates> {
  RellsCubit() : super(RellsInitialState());

  static RellsCubit get(context) => BlocProvider.of(context);
  // List<dynamic> rellsdata = [];
  reels_Model reels;
  getRells() {
    emit(RellsLoadingState());

    DioHelper.getData(
      url: 'reals',
      token: token,
    ).then((value) async {
      // mypost = post_model.fromJson(value.data);
      // print(mypost.data.data[0].details);
      //await rellsdata.addAll(value.data['data']['data']);
      reels = reels_Model.fromJson(value.data);

      //   print(mypost.data.data[0].details);
      //  print(postdata);
      emit(RellsSuccessState());
    }).catchError((error) {
      print(error);
      emit(RellsErrorState(error.toString()));
    });
  }

  postRells({dynamic videoSrc}) {
    emit(PostRellsLoadingState());

    DioHelper.postData(
      data: videoSrc,
      url: 'reals',
      token: token,
    ).then((value) async {
      // mypost = post_model.fromJson(value.data);
      // print(mypost.data.data[0].details);
      //  await rellsdata.addAll(value.data['data']['data']);
      // reels = reels_Model.fromJson(value.data);

      //   print(mypost.data.data[0].details);
      //  print(postdata);
      emit(PostRellsSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostRellsErrorState(error.toString()));
    });
  }

  int count;

  postLike({dynamic real_id}) {
    emit(PostLikeLoadingState());

    DioHelper.postData(
      data: {'real_id': real_id},
      url: 'like',
      token: token,
    ).then((value) async {
      count = value.data['data']['reaction_counts'];
      Fluttertoast.showToast(
          msg: "تم التفاعل بنجاح ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(PostLikeSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostLIkeErrorState(error.toString()));
    });
  }

  Commint comment;
  List<dynamic> mycomment = [];

  Future<void> getCommentReels(
      {dynamic number = 1, dynamic number2 = 1}) async {
    emit(RellsCommentLoadingState());

    DioHelper.getData(
      url: 'reals/$number?page=$number2',
      token: token,
    ).then((value) async {
      await mycomment.addAll(value.data['data']['data']);

      // print(value.data['data']['data']);
      //myComment.add(value.data['data']['data']);

      // comment = Commint.fromJson(value.data);
      //  print(comment.data.data[0].comment);
      //   print(mypost.data.data[0].details);
      Timer(Duration(seconds: 1), () {
        emit(RellsCommentSuccessState());
      });
    }).catchError((error) {
      print(error);
      emit(RellsCommentErrorState(error.toString()));
    });
  }

  postComment({int postId = 1, dynamic comment, dynamic type}) {
    emit(RellsPostCommentLoadingState());

    DioHelper.postData(
      data: {'comment': comment, 'post_id': postId, 'type': type},
      url: 'comments',
      token: token,
    ).then((value) {
      print(value);
      Fluttertoast.showToast(
          msg: "تم التعليق بنجاح ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(RellsPostCommentSuccessState());
    }).catchError((error) {
      print(error);
      emit(RellsPostCommentErrorState(error.toString()));
    });
  }
}
