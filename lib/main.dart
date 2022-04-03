import 'package:blog_web_app/models/blog_post.dart';
import 'package:blog_web_app/firebase_options.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:blog_web_app/models/user.dart';
import 'package:blog_web_app/pages/home_page.dart';
import 'package:blog_web_app/pages/store_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_web_app/models/user.dart';

var theme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
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
    bodyText2: TextStyle(fontSize: 22, height: 1.4),
    caption: TextStyle(fontSize: 18, height: 1.4),
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
        StreamProvider<bool>(
          create: (context) => FirebaseAuth.instance.authStateChanges().map((user) {
            print(user);
            // print('------${user!.email}----');
            // print('------${user.uid}----');
            return user != null;
          }),
          initialData: false,
        ),
        StreamProvider<List<BlogPost>>(
          initialData: [],
          create: (context) => blogPosts(),
        ),
        Provider<BlogUser>(
          create: (context) => BlogUser(
              name: 'Flutter Dev',
              profilePicture: 'https://i.ibb.co/G3ChDNX/MY-PHOTOT-ORIGINAL-Copy-3.jpg'),
        ),
        Provider<List<StoreItem>>(create: (context) => _storeItems),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dev Blog',
        theme: theme,
        home: StorePage(),
        routes: {
          '/store': (context) => StorePage(),
        },
      ),
    );
  }
}

Stream<List<BlogPost>> blogPosts() {
  return FirebaseFirestore.instance.collection('blogs').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => BlogPost.fromDocument(doc)).toList()
      ..sort((first, last) {
        final firstDate = first.publishedDate;
        final lastDate = last.publishedDate;
        return -firstDate.compareTo(lastDate);
      });
  });
}

final _storeItems = [
  StoreItem(
    name: 'Flutter Shirt',
    price: 12,
    imageUrl: 'https://i.ibb.co/SdCNQB8/1.png',
  ),
  StoreItem(
    name: 'Flutter Cap',
    price: 3,
    imageUrl: 'https://i.ibb.co/gP8BhLr/2.png',
  ),
  StoreItem(
    name: 'Flutter Mug',
    price: 4,
    imageUrl: 'https://i.ibb.co/t28Xxzq/3.png',
  ),
  StoreItem(
    name: 'Flutter Bottle',
    price: 13,
    imageUrl: 'https://i.ibb.co/bBThnXy/4.png',
  ),
];
