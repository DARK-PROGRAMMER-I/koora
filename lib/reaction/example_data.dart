import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

final defaultInitialReaction = Reaction<String>(
  value: null,
  icon: Row(
    children: [
      const Icon(Icons.linked_camera),
      const Icon(Icons.linked_camera),
    ],
  ),
);

final reactions = [
  Reaction<String>(
    value: 'heart',
    previewIcon: buildReactionsPreviewIcon('assets/images/heart.png'),
    icon: _buildReactionsIcon(
      'assets/images/heart.png',
    ),
  ),
  Reaction<String>(
    value: 'like',
    previewIcon: buildReactionsPreviewIcon('assets/images/like.png'),
    icon: _buildReactionsIcon(
      'assets/images/like.png',
    ),
  ),
  Reaction<String>(
    value: 'tears',
    previewIcon: buildReactionsPreviewIcon('assets/images/tears.png'),
    icon: _buildReactionsIcon(
      'assets/images/tears.png',
    ),
  ),
  Reaction<String>(
    value: 'surprised',
    previewIcon: buildReactionsPreviewIcon('assets/images/surprised.png'),
    icon: _buildReactionsIcon(
      'assets/images/surprised.png',
    ),
  ),
  Reaction<String>(
    value: 'sad',
    previewIcon: buildReactionsPreviewIcon('assets/images/sad.png'),
    icon: _buildReactionsIcon(
      'assets/images/sad.png',
    ),
  ),
  Reaction<String>(
    value: 'praying',
    previewIcon: buildReactionsPreviewIcon('assets/images/praying.png'),
    icon: _buildReactionsIcon(
      'assets/images/praying.png',
    ),
  ),
];

Padding _builFlagsdPreviewIcon(String path, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7.5),
        Image.asset(path, height: 30),
      ],
    ),
  );
}

Container _buildTitle(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Padding buildReactionsPreviewIcon(String path) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
    child: Image.asset(path, height: 40),
  );
}

Image _buildIcon(String path) {
  return Image.asset(
    path,
    height: 30,
    width: 30,
  );
}

Container _buildReactionsIcon(
  String path,
) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Image.asset(path, height: 20),
      ],
    ),
  );
}
