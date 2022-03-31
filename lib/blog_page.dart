import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_centre.dart';
import 'package:blog_web_app/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key, required this.blogPost}) : super(key: key);
  final BlogPost blogPost;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return BlogScaffold(
      children: [
        ConstrainedCentre(
          child: CircleAvatar(
            radius: 54,
            backgroundImage: NetworkImage(user.profilePicture),
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCentre(
          child: SelectableText(user.name, style: Theme.of(context).textTheme.headline5),
        ),
        SizedBox(height: 40),
        SelectableText(blogPost.title.toString(), style: Theme.of(context).textTheme.headline1),
        SizedBox(height: 20),
        SelectableText(blogPost.date, style: Theme.of(context).textTheme.caption),
        SizedBox(height: 20),
        SelectableText(blogPost.body.toString(), style: Theme.of(context).textTheme.headline5),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Blog'),
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
