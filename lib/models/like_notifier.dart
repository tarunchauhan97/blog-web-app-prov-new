import 'package:blog_web_app/models/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeNotifier extends ChangeNotifier {
  LikeNotifier({required this.post});

  final BlogPost post;
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void init() {
    _isLiked = post.isLiked!;
  }

  void toggleLike() {
    _isLiked = !_isLiked;
    FirebaseFirestore.instance.collection('blogs').doc(post.id).update({'is_liked': _isLiked});
    notifyListeners();
  }
}