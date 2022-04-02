import 'package:blog_web_app/like_notifier.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({Key? key, required this.likeNotifier}) : super(key: key);

  final LikeNotifier likeNotifier;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: likeNotifier.toggleLike,
      icon: Icon(likeNotifier.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined),
      style: TextButton.styleFrom(primary: likeNotifier.isLiked ? Colors.blueAccent : Colors.black),
      label: Text('Like'),
    );
  }
}