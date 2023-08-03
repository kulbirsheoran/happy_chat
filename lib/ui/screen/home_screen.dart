import 'package:flutter/material.dart';
import 'package:happy_chat/ui/const/icon_const.dart';
import 'package:happy_chat/ui/const/string_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: const Text(happyChat),
        leading: const Icon(Icons.home),
        actions: [
          //icon for search user
          //IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: search,),
          IconButton(onPressed: (){}, icon:more)
        ],
      ),
      // floating button for add new user
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,
        onPressed: () {  },
       // child: const Icon(Icons.add_comment_rounded),
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
