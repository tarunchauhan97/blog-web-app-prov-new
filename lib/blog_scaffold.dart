import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  BlogScaffold({Key? key, required this.children}) : super(key: key);

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
