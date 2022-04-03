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
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.6,
        children: [
          for (var item in _storeItems) ItemCard(item: item),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.name),
            Image.network(item.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$' + item.price.toString()),
                InkWell(child: TextButton(onPressed: () {}, child: Text('Add to cart')))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
