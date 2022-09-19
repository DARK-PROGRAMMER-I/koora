import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;

import '../reaction/example_data.dart';
import '../reaction/item.dart';

class myreactions extends StatelessWidget {
  final number;

  myreactions(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 20.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Image.asset('assets/images/heart.png', height: 30)],
        )

        // Item(
        //     Example.reactions,
        //     Reaction<String>(
        //       value: null,
        //       icon: Row(
        //         children: [
        //           number == 1
        //               ? buildReactionsPreviewIcon('assets/images/heart.png')
        //               : number == 2
        //                   ? Icon(Icons.heart_broken)
        //                   : Icon(Icons.link_outlined),
        //         ],
        //       ),
        //     ))

        );
  }
}
