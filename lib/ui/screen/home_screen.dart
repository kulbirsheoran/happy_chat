
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_chat/model/chat_user.dart';
import 'package:happy_chat/service/firebase_service.dart';
import 'package:happy_chat/ui/const/icon_const.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/widget/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];

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
          IconButton(onPressed: () {}, icon: more)
        ],
      ),
      // floating button for add new user
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
      body: StreamBuilder(
        // Use StreamBuilder widget to work with real-time data streams.
        stream: ApiService.fireStore.collection('users').snapshots(),

        builder: (context, snapshot) {
          //if data is loading
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );
            //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              // Create an empty list to store names.
              //   final list =[];
              //  if(snapshot.hasData){
              // Get the documents (records) from the snapshot.
              final data = snapshot.data?.docs;
              //Loop through each document in the data collection.
              // for(var i in data!) {
              //   // log('Data:${i.data()}');
              //   // log('Data:${jsonEncode(i.data())}');
              //   //
              //   // // Extract the 'name' field and add it to the list.
              //   // list.add(i.data()['name']);
              //
              //
              //
              //
              // }
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

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
