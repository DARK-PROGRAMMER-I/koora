import 'dart:async';
import 'dart:convert';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/items/commint_item.dart';
import 'package:koora_app/screens/bnb_screens/news/cubit/cubit.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

import '../../../components/global_componnets.dart';
import '../settings/edit_profile/cubit.dart';
import 'cubit/state.dart';

class CommintScreen extends StatefulWidget {
  int id;
  String type;
  String ImageSrc;
  EditProfileCubit cubitProfile;

  CommintScreen(this.id, this.type, this.ImageSrc, this.cubitProfile);

  @override
  _CommintScreenState createState() => _CommintScreenState();
}

class _CommintScreenState extends State<CommintScreen> {
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Channel channel;
  bool loading = false;

  String channelName = 'chat';
  String eventName = 'comment';
  int myPostId = 0;
  var commentText = TextEditingController();

  int currentPage = 1;

  NewsCubit comments = NewsCubit();
  fetchNews() {
    setState(() {
      // ignore: missing_return
      Builder(builder: (BuildContext context) {
        comments;
      });

      comments.getComment(number: widget.id, number2: currentPage);

      currentPage++;
      // mymessages = localchat.mymessages;
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    print(widget.id);
    print('this is id ');
    myPostId = widget.id;
    fetchNews();
    setState(() {
      setState(() {
        comments.mycomment;
      });
    });

    // TODO: implement initState
    super.initState();
    initPusher();
    print('12345566');
    scrollController.addListener(() {
      double minScroll = scrollController.position.maxScrollExtent;
      double maxScroll = scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels >= minScroll &&
          scrollController.position.pixels <= maxScroll) {
        setState(() {});
        print('1');
        print(currentPage);

        fetchNews();
      }
    });
  }

  Future<void> initPusher() async {
    channel = await Pusher.subscribe(channelName);

    channel.bind(eventName, (last) {
      final String data = last.data;
      _inEventData.add(data);

      //  print(last);
      print(data.toString());
    });

    eventStream.listen((data) {
      //Message message = Message.fromJson(data);

      // my_messages x = my_messages.fromJson(data);

      // print('dataaaaaaaaaaa');
      //  jsonDecode(data);
      print('hello word');

      setState(() {
        // localchat.mymessages;
        //comments.mycomment.add(json.decode(data)['message']);
        //print(localchat.mymessages);
        //    print('helo local_chat');
        if ('${widget.id}' == '${json.decode(data)['comment']['post_id']}') {
          comments.mycomment.insert(0, json.decode(data)['comment']);
        }

        print(json.decode(data));
        print('123456');
        // print(mymessages);

        //  messages.add(my_messages.fromJson(message['message']));
      });
    });
  }

  @override
  void dispose() {
    Pusher.unsubscribe(channelName);
    channel.unbind(eventName);
    _eventData.close();

    super.dispose();
    commentText.clear();
    comments.mycomment == [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewsCubit()..getComment(number: widget.id, number2: currentPage),
      child: BlocConsumer<NewsCubit, PostNewsStates>(
        listener: (context, state) {
          if (state is PostCommentSuccessState) {
            print('123321321333333333333333333333333333333333');
            widget.cubitProfile.getProfileinfo();
            //cubit2.myprofile;
          }
          var cubit = NewsCubit.get(context);

          if (cubit.mycomment.isNotEmpty && loading == false) {
            setState(() {
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  loading = true;
                });
              });
            });
          }
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: containerColor,
              appBar: AppBar(
                backgroundColor: containerColor,
                elevation: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20)
                              .add(EdgeInsets.only(top: 30)),
                          child: ConditionalBuilder(
                            builder: (context) => ListView.builder(
                                reverse: true,
                                controller: scrollController,
                                itemCount: comments.mycomment.length,
                                itemBuilder: (context, index) {
                                  return CommintItem(comments.mycomment[index]);
                                }),
                            condition: state is! GetCommentLoadingState,
                            fallback: (context) => const Center(
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          )),
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
                                      child: Image.network(
                                        "${widget.ImageSrc}",
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
                                      const EdgeInsets.only(top: 20, right: 10),
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
                                            postId: widget.id,
                                            type: widget.type);
                                        commentText.clear();
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
