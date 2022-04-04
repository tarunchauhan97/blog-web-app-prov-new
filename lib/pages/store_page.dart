import 'package:blog_web_app/common_widgets/blog_scaffold.dart';
import 'package:blog_web_app/models/cart_notifier.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/checkout');
              },
              icon: Icon(Icons.shopping_cart)),
        ],
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
    final isInCart = context.select<CartNotifier, bool>((cart) => cart.items.contains(item));
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
                //Consumer<CartNotifier>(
                // Selector<CartNotifier, bool>(
                //   selector: (context, cart) => cart.items.contains(item),
                //   builder: (_, isInCart, child) {
                //     //final isInCart = context.watch<CartNotifier>().items.contains(item);
                //     // final isInCart = cart.items.contains(item);
                //     print('item card rebuilt');
                //     return
                TextButton(
                  onPressed: isInCart ? null : () => context.read<CartNotifier>().add(item),
                  child: Text(isInCart ? 'Added' : 'Add to cart'),
                ),
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
