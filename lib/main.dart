import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'user.dart';

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
    // final authtyp = FirebaseAuth.instance.authStateChanges();
    // print(authtyp);
    // print('-----------${authtyp}---------');
    // //Instance of '_AsBroadcastStream<User?>'
    // // I/flutter (10907): -----------Instance of '_AsBroadcastStream<User?>'---------
    // //
    return MultiProvider(
      providers: [
        StreamProvider<bool>(
          create: (context) => FirebaseAuth.instance.authStateChanges().map((user) {
            print(user);
            print('------${user!.email}----');
            print('------${user.uid}----');
            return user != null;
            //initialData:  StreamProvider.value<User?>(value: null, initialData: null),
            //initialData: FirebaseAuth.instance.authStateChanges(),
          }),
          initialData: false,
        ),
        StreamProvider<List<BlogPost>>(
          initialData: [],
          create: (context) => blogPosts(),
        ),
        ProxyProvider<User, BlogUser>(
          create: (context) => BlogUser(
            name: 'Flutter Dev',
            profilePicture: 'https://i.ibb.co/G3ChDNX/MY-PHOTOT-ORIGINAL-Copy-3.jpg',
            isLoggedIn: false,
          ),
          update: (context, firebaseUser, blogUser) => BlogUser(
            profilePicture: blogUser!.profilePicture,
            name: blogUser.name,
            isLoggedIn: firebaseUser != null,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dev Blog',
        theme: theme,
        home: HomePage(),
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
