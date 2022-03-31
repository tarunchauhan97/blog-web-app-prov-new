import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/firebase_options.dart';
import 'package:blog_web_app/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

final theme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.grey.shade600,
  textTheme: TextTheme(
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
    headline1: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    headline2: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<BlogPost>>(
          initialData: [
            BlogPost(title: 'title', publishedDate: DateTime.now(), body: 'body'),
          ],
          create: (context) => blogPosts(),
        ),
        // Provider<List<BlogPost>>(create: (context) => _blogPosts),
        Provider<User>(
          create: (context) => User(
              name: 'Flutter Dev',
              profilePicture: 'https://i.ibb.co/G3ChDNX/MY-PHOTOT-ORIGINAL-Copy-3.jpg'),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Dev',
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        //just start
      ),
    );
  }
}

// Future<List<BlogPost>> blogPosts() {
//   return FirebaseFirestore.instance.collection('blogs').get().then((query) {
//     print('----------------------------');
//     print(query);
//     print(query.docs);
//     print(query.docs.map((e) => e['body']));
//     print(query.docs.map((e) => e['title']));
//     print('----------------------------');
//     return query.docs.map((doc) => BlogPost.fromDocument(doc)).toList();
//   });

Stream<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance.collection('blogs').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => BlogPost.fromDocument(doc)).toList()..sort((first,last){
      final firstDate = first.publishedDate;
      final lastDate = last.publishedDate;
      return -firstDate.compareTo(lastDate);

    });
  });
}
