import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:zw_app/view/test_page/provider_sample/modal/cart.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (_, index) {
            final List<String> entries = <String>['A', 'B', 'C'];
            final List<int> colorCodes = <int>[600, 500, 100];
            return Container(
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('sdf'),
            pinned: true,
            expandedHeight: 0,
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
              child: Stack(
            children: <Widget>[
              Text('sdlkfj'),
              Text('dlskfjskdlfj'),
            ],
          )),
//          SliverToBoxAdapter(
//            child: ListView.builder(
//              itemCount: 3,
//              itemBuilder: (_, index) {
//                final List<String> entries = <String>['A', 'B', 'C'];
//                final List<int> colorCodes = <int>[600, 500, 100];
//                return Container(
//                  height: 50,
//                  color: Colors.amber[colorCodes[index]],
//                  child: Center(child: Text('Entry ${entries[index]}')),
//                );
//              },
//            ),
//          ),
//          SliverList(
//              delegate:
//                  SliverChildBuilderDelegate((_, index) => _MyListItem(index))),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return FlatButton(
      onPressed: cart.items.contains(item) ? null : () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.check, semanticLabel: 'ADDED')
          : Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black54),
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.black54)),
      ),
      floating: true,
      pinned: true,
      actions: [
//        Container(
//          child: ,
//        ),
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart')),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  _MyListItem(this.index) : super(key: ValueKey(index));

  @override
  Widget build(BuildContext context) {
    var item = Item(index);
    var textTheme = Theme.of(context).textTheme.title;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
