import 'package:blog_web_app/blog_entry_page.dart';
import 'package:blog_web_app/blog_page.dart';
import 'package:blog_web_app/blog_post.dart';
import 'package:blog_web_app/like_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogListTile extends StatelessWidget {
  final BlogPost post;

  const BlogListTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<bool>(context);
    return ChangeNotifierProvider<LikeNotifier>(
      create: (context) => LikeNotifier(),
      builder: (context, child) {
        final likeNotifier = Provider.of<LikeNotifier>(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            InkWell(
              child: Text(post.title, style: TextStyle(color: Colors.blueAccent.shade700)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BlogPage(blogPost: post);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(post.date, style: Theme.of(context).textTheme.caption),
                TextButton.icon(
                  onPressed: likeNotifier.toggleLike,
                  icon: Icon(likeNotifier.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined),
                  style: TextButton.styleFrom(
                      primary: likeNotifier.isLiked ? Colors.blueAccent : Colors.black),
                  label: Text('Like'),
                ),
                if (isUserLoggedIn) Blog_PopUp_Menu_Button(post: post),
              ],
            ),
            Divider(thickness: 2),
          ],
        );
      },
    );
  }
}

class Blog_PopUp_Menu_Button extends StatelessWidget {
  const Blog_PopUp_Menu_Button({
    Key? key,
    required this.post,
  }) : super(key: key);

  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
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
        switch (value) {
          case Action.edit:
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BlogEntryPage(post: post);
              },
            ));
            break;
          case Action.delete:
            FirebaseFirestore.instance.collection('blogs').doc(post.id).delete();
            //.then((value) => Navigator.of(context).pop());
            break;
          default:
        }
      },
    );
  }
}

enum Action { edit, delete }
