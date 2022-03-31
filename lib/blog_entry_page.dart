import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogEntryPage extends StatelessWidget {
  const BlogEntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _textTheme = Theme.of(context).textTheme;
    final titleController = TextEditingController(text: '');
    final bodyController = TextEditingController(text: '');
    return BlogScaffold(
      children: [
        TextField(
          controller: titleController,
          maxLines: null,
          style: _textTheme.headline1,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
          ),
        ),
        TextField(
          controller: bodyController,
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
        onPressed: () {
          final title = titleController.text;
          final body = bodyController.text;
          final blogPost = BlogPost(
            title: title,
            publishedDate: DateTime.now(),
            body: body,
          ).toMap();
          FirebaseFirestore.instance
              .collection('blogs')
              .add(blogPost)
              .then((_) => Navigator.of(context).pop());
        },
      ),
    );
  }
}
