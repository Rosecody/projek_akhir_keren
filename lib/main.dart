import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_item_screen.dart';

void main() {
  runApp(LostAndFoundApp());
}

class LostAndFoundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost and Found',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
      ),
      home: HomeScreen(),
      routes: {
        AddItemScreen.routeName: (context) => AddItemScreen(),
      },
    );
  }
}
