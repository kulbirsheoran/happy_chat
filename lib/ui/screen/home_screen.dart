
import 'package:flutter/material.dart';
import 'package:happy_chat/model/chat_user.dart';
import 'package:happy_chat/service/firebase_service.dart';
import 'package:happy_chat/ui/const/icon_const.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/screen/profile_screen.dart';
import 'package:happy_chat/ui/widget/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this list used for store user data;
  List<ChatUser> list = [];
 @override
  void initState() {
    super.initState();
    ApiService.getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(happyChat),
        leading: const Icon(Icons.home),
        actions: [
          //icon for search user
          //IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: search,
          ),
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProfileScreen(user: ApiService.me,)));
          }, icon: more)
        ],
      ),
      // floating button for add new user
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          // await FirebaseAuth.instance.signOut();
          // await GoogleSignIn().signOut();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
      body: StreamBuilder(
        // Use StreamBuilder widget to work with real-time data streams.
        stream: ApiService.getAllUsers(),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              //waiting is used for when data is loading it show circular indicator
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:

              final data = snapshot.data?.docs;

              list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ChatUserCard(user: list[index]);
                      //Text('Name:${list[index]}');
                    });
              } else {
                return const Center(
                    child: Text(
                  'no user found!',
                  style: TextStyle(fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}
