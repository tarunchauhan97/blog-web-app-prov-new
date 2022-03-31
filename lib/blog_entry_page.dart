import 'package:blog_web_app/blog_scaffold.dart';
import 'package:flutter/material.dart';

class BlogEntryPage extends StatelessWidget {
  const BlogEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    return BlogScaffold(
      children: [
        TextField(
          maxLines: null,
          style: _textTheme.headline1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
          ),
        ),
        TextField(
          maxLines: null,
          style: _textTheme.bodyText2,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write your Blog',
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Submit'),
        icon: Icon(Icons.book),
        onPressed: () {},
      ),
    );
  }
}
