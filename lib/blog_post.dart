import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  const BlogPost({
    this.isLiked,
    this.id,
    required this.title,
    required this.publishedDate,
    required this.body,
  });

  final String title;

  final DateTime publishedDate;

  final String body;
  final String? id;
  final bool? isLiked;

  String get date => DateFormat('d MMM y').format(publishedDate);

  factory BlogPost.fromDocument(DocumentSnapshot doc) {
    //final Map<String, dynamic> map = doc.data();
    final map = doc.data() as Map;
    print('/////////');
    print(map);

    if (map == null)
      return BlogPost(
        title: 'title',
        publishedDate: DateTime.now(),
        body: 'body',
        id: '00',
        isLiked: false,
      );
    return BlogPost(
      title: map['title'],
      publishedDate: map['published_date'].toDate(),
      body: map['body'],
      id: doc.id,
      isLiked: map['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'published_date': Timestamp.fromDate(publishedDate),
    };
  }
}

//final timeStamp = Timestamp.fromDate(DateTime.now()).toDate();
