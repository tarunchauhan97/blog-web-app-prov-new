import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_centre.dart';
import 'package:blog_web_app/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<BlogPost>>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    return BlogScaffold(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedCentre(
          child: CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                //'https://ibb.co/7Nr9DLH',
                user.profilePicture),
          ),
        ),
        SizedBox(height: 18),
        ConstrainedCentre(
          child: SelectableText(
            user.name,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 40),
        SelectableText(
          'Hello, I’m a Tarun. I’m a Flutter developer.',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 40),
        SelectableText(
          'Blog',
          style: Theme.of(context).textTheme.headline2,
        ),
        for (var post in posts) BlogListTile(post: post),
      ],
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Blog'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => BlogEntryPage()),
          );
        },
      ),
    );
  }
}

class BlogListTile extends StatelessWidget {
  const BlogListTile({Key? key, required this.post}) : super(key: key);

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    //final title = Provider.of<String>(context,listen: false);
    //final date = Provider.of<DateTime>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        InkWell(
          child: Text(
            post.title,
            style: TextStyle(color: Colors.blueAccent.shade700),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => BlogPage(blogPost: post)));
          },
        ),
        SizedBox(height: 10),
        SelectableText(
          //'$date',
          //post.publishedDate,
          // DateFormat('d MMMM y').format(post.publishedDate),
          // style: Theme.of(context).textTheme.caption,
          post.date,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
