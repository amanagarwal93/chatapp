import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: const Text('We Chat'),
        actions: [
          //search button
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          // more action button
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      // floating action button to add a new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10,right: 10),
        child: FloatingActionButton(
            onPressed: () {}, child: Icon(Icons.add_comment_rounded)),
      ),
    );
  }
}
