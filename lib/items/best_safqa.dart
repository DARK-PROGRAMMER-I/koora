import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;
import 'package:koora_app/reaction/item.dart';

import '../model/postMode.dart';
import '../screens/bnb_screens/news/cubit/cubit.dart';
import '../screens/bnb_screens/news/cubit/state.dart';
import 'commint_item.dart';

class safqa extends StatefulWidget {
  final Options options;
  int index;

  safqa(this.options, this.index);

  @override
  State<safqa> createState() => _safqaState();
}

class _safqaState extends State<safqa> {
  var vote;
  var percentage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vote = widget.options.vote;
    percentage = widget.options.percentage;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);

    return BlocConsumer<NewsCubit, PostNewsStates>(
      listener: (context, state) {
        if (state is PostVoiteSuccessState) {
          setState(() {
            vote = cubit.voitemodel.data.options[widget.index].vote;
            percentage = cubit.voitemodel.data.options[widget.index].percentage;

            print(vote);
          });
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            await cubit.postVoite(postId: widget.options.id);
            setState(() {});
          },
          child: Column(
            children: [
              Container(
                width: 130.0.w,
                height: 130.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(widget.options.image),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              myArabicText(' $vote صوت', 16, FontWeight.normal, Colors.white),
              SizedBox(
                height: 15.h,
              ),
              myArabicText('$percentage', 16, FontWeight.normal, Colors.white),
            ],
          ),
        );
      },
    );
  }
}
