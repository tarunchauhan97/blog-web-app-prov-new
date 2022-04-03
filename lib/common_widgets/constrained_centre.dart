import 'package:flutter/material.dart';

class ConstrainedCentre extends StatelessWidget {
  final Widget child;

  const ConstrainedCentre({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, child: Center(child: child));
  }
}
