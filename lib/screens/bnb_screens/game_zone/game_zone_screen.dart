import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/ad_mob/banner_ad.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/reels_item.dart';

import 'add_comment_reels_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class GameZoneScreen extends StatefulWidget {
  @override
  _GameZoneScreenState createState() => _GameZoneScreenState();
}

class _GameZoneScreenState extends State<GameZoneScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> videos = [
      'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
      'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
    ];

    var height =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return BlocProvider(
      create: (BuildContext context) => RellsCubit()..getRells(),
      child: BlocConsumer<RellsCubit, RellsStates>(
        listener: (context, state) {
          var cubit = RellsCubit.get(context);
          if (state is PostRellsSuccessState) {
            cubit.getRells();

            setState(() {});
          }
        },
        builder: (context, state) {
          var cubit = RellsCubit.get(context);
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AdBanner("ca-app-pub-1206837523110524/1697130714"),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: (MediaQuery.of(context).size.height - height) * 0.65,
                child: cubit.reels != null
                    ? Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return ReelsItem(
                            src: cubit.reels.data.data[index].video,
                            reactions: cubit.reels.data.data[index],
                          );
                        },
                        itemCount: cubit.reels.data.data.length,
                        scrollDirection: Axis.vertical,
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        },
      ),
    );
  }
}
//ReelsItem
