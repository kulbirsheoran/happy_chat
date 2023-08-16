


import 'package:flutter/material.dart';
import 'package:happy_chat/model/chat_user.dart';
import 'package:happy_chat/provider/home_screen_provider.dart';
import 'package:happy_chat/service/firebase_service.dart';
import 'package:happy_chat/ui/const/icon_const.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/screen/profile_screen.dart';
import 'package:happy_chat/ui/widget/chat_user_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this list used for store user data;
  List<ChatUser> list = [];
  //for storing search items
  List<ChatUser> searchList = [];
  //for storing search status
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    ApiService.getSelfInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder:((context,homeScreenProvider,child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: WillPopScope(
              onWillPop: () {

                  if(_isSearching){

                  _isSearching=!_isSearching;

                  return Future.value(false);
                }else{
                  return Future.value(true);

                }
                  //homeScreenProvider.exit();

              },
              child: Scaffold(
                appBar: AppBar(
                  title:
                  // homeScreenProvider.search() ,
                  _isSearching ? TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Name,Email...'),
                      autofocus: true,
                      style: const TextStyle(fontSize: 12, letterSpacing: 0.5),

                      onChanged: (val) {
                       // homeScreenProvider.search(val);
                        searchList.clear();
                        for (var i in list) {
                          if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                              i.email.toLowerCase().contains(val.toLowerCase())) {
                            searchList.add(i);
                          }
                        }
                      }
                  ):const Text(happyChat),
                  leading: const Icon(Icons.home),
                  actions: [

                    IconButton(
                        onPressed: () {

                         // homeScreenProvider.isSearch();
                          setState(() {
                            _isSearching = !_isSearching;
                          });
                        },
                        icon: Icon(_isSearching ? Icons.clear : Icons.search)
                    ),
                    IconButton(onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) =>
                          ProfileScreen(user: ApiService.me,)));
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

                        list = data?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ?? [];

                        if (list.isNotEmpty) {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  decelerationRate: ScrollDecelerationRate.fast),
                              itemCount: _isSearching ? searchList.length : list
                                  .length,
                              itemBuilder: (context, index) {
                                return ChatUserCard(user: _isSearching
                                    ? searchList[index]
                                    : list[index]);
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
              ),
            ),
          );

        }
        )
    );
  }
}
