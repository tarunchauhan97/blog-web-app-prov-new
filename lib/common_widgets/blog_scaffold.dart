import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final bool isScrollable;
  final Widget? body;

  const BlogScaffold({
    Key? key,
    required this.children,
    this.floatingActionButton,
    this.appBar,
    required this.isScrollable,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var columnWidget = isScrollable
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );

    return Scaffold(
      appBar: appBar ?? AppBar(),
      backgroundColor: Colors.blueGrey,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: body ?? columnWidget,
          // child: SingleChildScrollView(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: body ?? children,
          //   ),
          // ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
