import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/notification_item.dart';
import 'package:koora_app/screens/bnb_screens/settings/setting/notifications/state.dart';

import '../../../../../model/notifications_Model.dart';
import 'cubit.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationsCubit news = NotificationsCubit();
  int currentPage = 1;
  bool loading = false;

  fetchNews() {
    setState(() {
      // ignore: missing_return
      Builder(builder: (BuildContext context) {
        news;
      });

      news.getNotifications(number: currentPage);

      currentPage++;
      // mymessages = localchat.mymessages;
      // print(mymessages);
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    fetchNews();
    setState(() {
      setState(() {
        news.postdata;
      });
    });

    // TODO: implement initState
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var height =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return BlocProvider(
      create: (BuildContext context) =>
          NotificationsCubit()..getNotifications(),
      child: BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! GetNotificationsLoadingState,
            builder: (context) => buildWidget(news.mynotifications2),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget buildWidget(data) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff20272D),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(0xff283037),
          centerTitle: true,
          title: myArabicText(
            "الإشعارات",
            15,
            FontWeight.bold,
            Colors.white,
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icons/back_icon.png",
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: ListView.builder(
              itemCount: news.mynotifications2.length,
              itemBuilder: (context, index) {
                return NotificationItem(data[index]);
              }),
        ),
      ),
    );
  }
}
