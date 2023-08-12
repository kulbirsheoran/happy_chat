import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_chat/helper/dialogs.dart';
import 'package:happy_chat/model/chat_user.dart';
import 'package:happy_chat/ui/auth/login_screen.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {  Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
             // Navigator.of(context).pop();
            },
          ),
          title: const Text('ProfileScreen'),
        ),
        // floating button for add new user
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut().then((value) {Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            });
          },
          icon: const Icon(Icons.add_comment_rounded),
          label: const Text('LogOut'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    width: double.maxFinite,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(70)),
                        child: CachedNetworkImage(
                          height: 140,
                          width: 140,
                          imageUrl: widget.user.image,
                          fit: BoxFit.cover,
                          //   placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            onPressed: () {},
                            shape: CircleBorder(),

                            child: Icon(Icons.edit,color: Colors.blue,),
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.user.email,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    initialValue: widget.user.name,
                    decoration: InputDecoration(
                        hintText: 'eg. Kulbir',
                        label: const Text('Name'),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    decoration: InputDecoration(
                        hintText: 'eg. feeling',
                        label: const Text('About'),
                        prefixIcon: const Icon(
                          Icons.info_outline_rounded,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(100, 40)),
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      'Update',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
