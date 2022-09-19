import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;

class Item extends StatefulWidget {
  final reactions;
  final initialReaction;

  Item(this.reactions, this.initialReaction);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ReactionButtonToggle<String>(
                  onReactionChanged: (String value, bool isChecked) {
                    debugPrint('Selected value: $value, isChecked: $isChecked');
                  },
                  reactions: widget.reactions,
                  initialReaction: widget.initialReaction,
                  selectedReaction: widget.reactions[1],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
