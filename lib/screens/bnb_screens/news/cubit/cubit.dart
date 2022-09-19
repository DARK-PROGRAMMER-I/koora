// ignore_for_file: await_only_futures

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/model/comment.dart';
import 'package:koora_app/model/postMode.dart';
import 'package:koora_app/model/voteModel.dart';
import 'package:koora_app/screens/bnb_screens/news/cubit/state.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/dio_helper.dart';

class NewsCubit extends Cubit<PostNewsStates> {
  NewsCubit() : super(PostNewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  post_model mypost;
  List<dynamic> postdata = [];
  List<Data3> mypost2 = [];

  getNews({int number = 1}) {
    emit(PostNewsLoadingState());

    DioHelper.getData(
      url: 'posts?page=$number',
      token: token,
    ).then((value) async {
      // mypost = post_model.fromJson(value.data);
      // print(mypost.data.data[0].details);
      mypost = post_model.fromJson(value.data);
      mypost2.addAll(mypost.data.data);
      //   print(mypost.data.data[0].details);
      //  print(postdata);
      Timer(Duration(seconds: 1), () {
        emit(PostNewsSuccessState(mypost));
      });
    }).catchError((error) {
      print(error);
      emit(PostNewsErrorState(error.toString()));
    });
  }

  Commint comment;
  List<dynamic> mycomment = [];

  Future<void> getComment({dynamic number = 1, dynamic number2 = 1}) async {
    emit(GetCommentLoadingState());

    DioHelper.getData(
      url: 'comments/$number?page=$number2',
      token: token,
    ).then((value) async {
      await mycomment.addAll(value.data['data']['data']);

      // print(value.data['data']['data']);
      //myComment.add(value.data['data']['data']);

      // comment = Commint.fromJson(value.data);
      //  print(comment.data.data[0].comment);
      //   print(mypost.data.data[0].details);
      Timer(Duration(seconds: 1), () {
        emit(GetCommentSuccessState());
      });
    }).catchError((error) {
      print(error);
      emit(GetCommentErrorState(error.toString()));
    });
  }

  postComment({int postId = 1, dynamic comment, dynamic type}) {
    emit(PostCommentLoadingState());

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
      emit(PostCommentSuccessState());
    }).catchError((error) {
      print(error);
      emit(PostCommentErrorState(error.toString()));
    });
  }

  Map<String, dynamic> Postvote;
  voiteModel voitemodel;
  var vote;
  var percentage;
  postVoite({dynamic postId}) {
    emit(PostVoiteLoadingState());

    DioHelper.postData(
      data: {
        'option_id': postId,
      },
      url: 'vote',
      token: token,
    ).then((value) {
      voitemodel = voiteModel.fromJson(value.data);
      print(value.data);
      //  print(value);
      // Postvote = ;
      Fluttertoast.showToast(
          msg: 'تم التصويت بنجاح',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(PostVoiteSuccessState(voitemodel));
    }).catchError((error) {
      print(error);
      emit(PostVoiteErrorState(error.toString()));
    });
  }

  post_model likeforpost;
  int count = 0;
  bool color;
  bool isfavourite;
  int id;
  LikePost({dynamic reaction_id = 1, post_id}) {
    count = 0;
    emit(PostLikeLoadingState());

    DioHelper.postData(
      data: {'reaction_id': reaction_id, 'post_id': post_id},
      url: 'post-reaction',
      token: token,
    ).then((value) {
      // likeforpost = post_model.fromJson(value.data);
      // print(likeforpost.data.data[0].reactionCounts);
      count = value.data['data']['reaction_counts'];
      color = value.data['data']['is_like'];
      id = value.data['data']['id'];
      final mymessage = value.data['message'];
      Fluttertoast.showToast(
          msg: "${mymessage}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Timer(Duration(seconds: 0), () {
        emit(PostLikeSuccessState());
      });
    }).catchError((error) {
      print(error);
      emit(PostLikeErrorState(error.toString()));
    });
  }
}
