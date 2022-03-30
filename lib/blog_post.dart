import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BlogPost {
  const BlogPost({required this.title, required this.publishedDate, required this.body});

  final String title;

  final DateTime publishedDate;

  final String body;

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
      );
    return BlogPost(
      title: map['title'],
      publishedDate: map['published_date'].toDate(),
      //publishedDate: map['published_date'].toDate() ?? DateTime.now(),
      //publishedDate: DateTime.parse(map['published_data'].toDate()),
      //publishedDate: DateTime.now(),
      body: map['body'],
    );
  }
}

//final timeStamp = Timestamp.fromDate(DateTime.now()).toDate();
