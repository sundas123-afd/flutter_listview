// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BodyLayout(),
    ),
  );
}

class BodyLayout extends StatefulWidget {
  const BodyLayout({super.key});

  @override
  BodyLayoutState createState() => BodyLayoutState();
}

class BodyLayoutState extends State<BodyLayout> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<String> _data = ['Sun', 'Moon', 'Star'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated List Example")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_data[index], animation);
              },
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            child: const Text('Insert item', style: TextStyle(fontSize: 20)),
            onPressed: _insertSingleItem,
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            child: const Text('Remove item', style: TextStyle(fontSize: 20)),
            onPressed: _removeSingleItem,
          )
        ],
      ),
    );
  }

  // Animated list tile
  Widget _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    int insertIndex = 2; // Example index

    if (insertIndex > _data.length) return;

    _data.insert(insertIndex, newItem);
    _listKey.currentState!.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = 2;

    if (removeIndex >= _data.length) return;

    String removedItem = _data.removeAt(removeIndex);

    final builder = (BuildContext context, Animation<double> animation) {
      return _buildItem(removedItem, animation);
    };

    _listKey.currentState!.removeItem(removeIndex, builder);
  }
}

// Removed local class to use Flutter's typedef AnimatedListRemovedItemBuilder.
