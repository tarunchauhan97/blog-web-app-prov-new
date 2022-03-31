import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/blog_scaffold.dart';
import 'package:blog_web_app/constrained_centre.dart';
import 'package:blog_web_app/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              post.date,
              style: Theme.of(context).textTheme.caption,
            ),
            PopupMenuButton<Action>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Edit'),
                    value: Action.edit,
                  ),
                  PopupMenuItem(
                    child: Text('Delete'),
                    value: Action.delete,
                  ),
                ];
              },
              onSelected: (value) {
                print(value);
                print('print(value);$value');
                switch (value) {
                  case Action.edit:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return BlogEntryPage(post: post);
                    }));
                    break;
                  case Action.delete:
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            contentPadding: EdgeInsets.all(18),
                            children: [
                              Text('Are you sure you want to delete'),
                              Text(
                                post.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    child: Text('Delete'),
                                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('blogs')
                                          .doc(post.id)
                                          .delete()
                                          .then((value) => Navigator.of(context).pop());
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('Cancel')),
                                ],
                              ),
                            ],
                          );
                        });
                    break;
                  default:
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

enum Action { edit, delete }
