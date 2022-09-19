// ignore_for_file: missing_required_param

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/my_massege_item.dart';
import 'package:koora_app/items/other_massege_item.dart';
import 'package:koora_app/model/Message.dart';
import 'package:koora_app/model/conversation_model.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit/cubit.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit/state.dart';
import 'package:koora_app/screens/bnb_screens/my_team_chat/cubit_global/cubit.dart';

import 'package:koora_app/shared/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

import '../../../ad_mob/banner_ad.dart';
import 'cubit_global/state.dart';

class GlobalClubChatScreen extends StatefulWidget {
  final id;

  GlobalClubChatScreen(this.id);
  @override
  _GlobalClubChatScreenState createState() => _GlobalClubChatScreenState();
}

class _GlobalClubChatScreenState extends State<GlobalClubChatScreen> {
  GlobalTeamChatCubit localchat = GlobalTeamChatCubit();

  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;

  Channel channel;

  String channelName = 'global-chat';
  String eventName = 'message';

  List<my_messages> messages = [];
  List<dynamic> mymessages = [];
  int length = 0;
  int currentPage = 1;
  File _file;
  bool loading = false;

  fetchNews() {
    setState(() {
      // ignore: missing_return
      Builder(builder: (BuildContext context) {
        localchat;
      });

      localchat.getGlobalTeamChat(number: currentPage);

      currentPage++;
      // mymessages = localchat.mymessages;
      print(mymessages);
    });
  }

  ScrollController scrollController = ScrollController();

  var message = TextEditingController();

  @override
  void initState() {
    fetchNews();
    setState(() {
      localchat.mymessagesGlobal;
    });

    super.initState();
    initPusher();

    scrollController.addListener(() {
      double minScroll = scrollController.position.maxScrollExtent - 100.h;
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
      // print(data.toString());
    });
    eventStream.listen((data) async {
      //Message message = Message.fromJson(data);

      // my_messages x = my_messages.fromJson(data);

      // print('dataaaaaaaaaaa');
      //  jsonDecode(data);

      setState(() {
        // localchat.mymessages;
        // localchat.mymessages.add(json.decode(data)['message']);
        //print(localchat.mymessages);
        //    print('helo local_chat');
        if ('${widget.id}' == json.decode(data)['message']['team_id']) {
          localchat.mymessagesGlobal.insert(0, json.decode(data)['message']);
        }
        length;
        print(data);
        // print(mymessages);

        //  messages.add(my_messages.fromJson(message['message']));
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('12345');
  }

  @override
  void dispose() {
    Pusher.unsubscribe(channelName);
    channel.unbind(eventName);
    _eventData.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          GlobalTeamChatCubit()..getGlobalTeamChat(),
      child: BlocConsumer<GlobalTeamChatCubit, GlobalTeamChatStates>(
        listener: (context, state) async {
          var cubit = GlobalTeamChatCubit.get(context);

          if (cubit.mymessagesGlobal.isNotEmpty) {
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                loading = true;
              });
            });
          }
          // Future.delayed(const Duration(seconds: 5), () {
          //   LocatTeamChatCubit.get(context).getLocatTeamChat();
          //   setState(() {
          //     LocatTeamChatCubit.get(context).conversation_model;
          //   });
          // });
        },
        builder: (context, state) {
          var cubit = GlobalTeamChatCubit.get(context);

          String fileName;
          Future<dynamic> uploadImage(File file) async {
            String fileName = file.path.split('/').last;
            FormData formData = FormData.fromMap({
              "image":
                  await MultipartFile.fromFile(file.path, filename: fileName),
            });
            await cubit.postGlobalTeamChat(data: formData);
          }

          //mymessages = cubit.mymessages;
          length = mymessages.length;
          // List<dynamic> mymessage_order = [];
          // int k = 0;
          // for (int i = mymessages.length; i >= 0; i--) {
          //   mymessage_order.add(mymessages[i]);
          // }
          //print(mymessage_order);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: containerColor,
                    centerTitle: true,
                    title: Text(
                      "النادي العالمي",
                      style: TextStyle(
                          fontSize: 16.sp,
                          // color: color,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'tajawal'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  backgroundColor: Color(0xff21282F),
                  body:
                      //LocatTeamChatCubit.get(context).conversation_model != null
                      Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child:
                            AdBanner("ca-app-pub-1206837523110524/1697130714"),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        controller: scrollController,
                        reverse: true,
                        child: loading
                            ? Builder(builder: (context) {
                                return ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: localchat.mymessagesGlobal.length,
                                  // ignore: missing_return
                                  itemBuilder: (context, index) {
                                    length--;
                                    // ignore: unrelated_type_equality_checks
                                    // String x = cubit.conversation_model.data
                                    //     .data[index].user.id;
                                    // String y = userId;
                                    // ignore: unrelated_type_equality_checks

                                    // print(userId);
                                    //cubit
                                    //   .conversation_model.data.data[index]
                                    //
                                    //print(userId);
                                    //
                                    //     print('this is user id ');
                                    // print(mymessages[index]['user']
                                    //     ['id']);
                                    print(localchat.mymessagesGlobal[index]
                                        ['user']['id']);
                                    if ('$userId' ==
                                        '${(localchat.mymessagesGlobal[index]['user']['id'])}') {
                                      print(userId);
                                      print('this is user Id');
                                      return MyMassegeItem(
                                          localchat.mymessagesGlobal[index]);
                                    }
                                    //   }
                                    else {
                                      //print(userId);

                                      return OtherMassegeItem(
                                          localchat.mymessagesGlobal[index]);
                                    }
                                  },
                                );
                              })
                            : Center(
                                child: Center(
                                child: Lottie.asset(
                                    'assets/lottiefiles/kora.json',
                                    height: 250.h),
                              )),
                      )),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: message,
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
                                  contentPadding: EdgeInsets.only(top: 25),
                                  hintText: "نص الرسالة",
                                  hintStyle: const TextStyle(
                                    color: hintTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: 'tajawal',
                                  ),

                                  filled: true,
                                  fillColor: textFieldColor,
                                  // border: OutlineInputBorder(
                                  //     borderSide: BorderSide.none,
                                  //     borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: InkWell(
                                      onTap: () async {
                                        await cubit.postGlobalTeamChat(
                                            data: {'message': message.text});

                                        message.clear();
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
                          /*     InkWell(
                              onTap: () async {
                                print('object');
                                await ImagePicker()
                                    .pickImage(source: ImageSource.camera)
                                    .then((value) async {
                                  setState(() {
                                    _file = File(value.path);
                                    //fileName = _file.path.split('/').last;
                                  });
                                  print(_file.path);
                                  print('this is file ');
                                });
                                uploadImage(_file);

                                //await uploadImage(_file);
                              },
                              child: Image.asset(
                                "assets/icons/cam_icon.png",
                                width: 30,
                              )),*/
                          InkWell(
                              onTap: () async {
                                print('object');
                                await ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) async {
                                  setState(() {
                                    _file = File(value.path);
                                    //fileName = _file.path.split('/').last;
                                  });
                                  print(_file.path);
                                  print('this is file ');
                                });
                                uploadImage(_file);

                                //await uploadImage(_file);
                              },
                              child: Image.asset(
                                "assets/icons/image_icon.png",
                                width: 50,
                              )),
                        ],
                      ),
                    ],
                  )));
        },
      ),
    );
  }
}
