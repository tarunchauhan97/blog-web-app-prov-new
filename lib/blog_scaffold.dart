import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  BlogScaffold({Key? key, required this.children, required this.floatingActionButton})
      : super(key: key);

  final List<Widget> children;
  final Widget floatingActionButton;

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
      floatingActionButton: floatingActionButton,
    );
  }
}
