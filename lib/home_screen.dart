import 'package:flutter/material.dart';
import '../models/item.dart';
import 'add_item_screen.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [];

  void _addItem(String name, String description, String imagePath) {
    final newItem =
        Item(name: name, description: description, imagePath: imagePath);
    setState(() {
      _items.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost and Found'),
      ),
      body: _items.isEmpty
          ? Center(child: Text('No items reported yet.'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: _items[index].imagePath.isNotEmpty
                      ? Image.file(
                          File(_items[index].imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : null,
                  title: Text(_items[index].name),
                  subtitle: Text(_items[index].description),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AddItemScreen.routeName)
                  as Map<String, String>?;
          if (result != null) {
            _addItem(
                result['name']!, result['description']!, result['imagePath']!);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
