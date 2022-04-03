import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:blog_web_app/models/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StoreItems on BuildContext {
  List<StoreItem> getStoreItems() {
    return Provider.of<List<StoreItem>>(this);
  }
}

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _storeItems = Provider.of<List<StoreItem>>(context);
    //final _storeItems = context.watch<List<StoreItem>>();
    final _storeItems = context.getStoreItems();
    return BlogScaffold(
      isScrollable: true,
      appBar: AppBar(
        title: Text('Store', style: TextStyle(color: Colors.black)),
      ),
      children: [],
    );
  }
}
