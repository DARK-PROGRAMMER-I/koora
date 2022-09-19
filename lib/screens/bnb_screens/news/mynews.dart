import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/ad_mob/banner_ad.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/items/best_safqa.dart';
import 'package:koora_app/items/postdata.dart';
import 'package:koora_app/items/vote.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;
import 'package:koora_app/reaction/item.dart';
import 'package:koora_app/screens/bnb_screens/news/cubit/cubit.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/global_componnets.dart';
import 'commints_screen.dart';
import 'cubit/state.dart';

class MyNews extends StatefulWidget {
  @override
  State<MyNews> createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  NewsCubit news = NewsCubit();
  int currentPage = 1;
  bool loading = false;

  fetchNews() {
    setState(() {
      // ignore: missing_return
      Builder(builder: (BuildContext context) {
        news;
      });

      news.getNews(number: currentPage);

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
    WidgetsBinding.instance.addPostFrameCallback((_) => buildWidget(context));
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
      create: (BuildContext context) => NewsCubit()..getNews(),
      child: BlocConsumer<NewsCubit, PostNewsStates>(
        listener: (context, state) {
          var cubit = NewsCubit.get(context);

          // if (state is PostNewsSuccessState &&
          //     cubit.mypost2.isNotEmpty &&
          //     loading == false) {
          //   setState(() {
          //     loading = true;
          //   });
          // }
          setState(() {});

          if (state is PostVoiteSuccessState) {
            // setState(() {
            //   news.mypost2;
            // });

            Fluttertoast.showToast(
                msg: 'تم التصويت بنجاح',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          if (state is PostVoiteErrorState) {
            // setState(() {
            //   news.mypost2;
            // });

            Fluttertoast.showToast(
                msg: 'تم التصويت سابقاً',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          return ConditionalBuilder(
            condition: state is! PostNewsLoadingState,
            builder: (context) => buildWidget(news.mypost2),
            fallback: (context) => Center(
                child: Lottie.asset('assets/lottiefiles/kooraloading.json')),
          );
        },
      ),
    );
  }

  Widget buildWidget(data) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: AdBanner("ca-app-pub-1206837523110524/1697130714"),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: news.mypost2.length,

                    // ignore: missing_return
                    itemBuilder: (ctx, index) {
                      return data[index].options.isEmpty
                          // news.postdata[index]['options'].isEmpty
                          ? posts(data[index], index)
                          : voite(data[index]);
                      // if (news.postdata[index]['options'].isEmpty) {
                      //   return posts(news.postdata[index]);
                      // } else {
                      //   // return voite(cubit.mypost.data.data[index]);
                      // }
                    }))
          ],
        ),
      ),
    );
  }
}
