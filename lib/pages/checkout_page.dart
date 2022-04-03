import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = context.watch<CartNotifier>().items;
    print('-----$_items----');
    //return BlogScaffold(
    return BlogScaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      //isScrollable: true,
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          //final item = _items[index];
          final item = _items.elementAt(index);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(item.imageUrl),
            ),
            title: Text(item.name),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {},
            ),
          );
        },
      ),
      isScrollable: true,
      children: [],
    );
  }
}
