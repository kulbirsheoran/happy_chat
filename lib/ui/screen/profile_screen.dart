import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:happy_chat/model/chat_user.dart';
import 'package:happy_chat/provider/profile_provider.dart';
import 'package:happy_chat/service/firebase_service.dart';

import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<ProfileScreenProvider>(
          builder: ((context, profileScreenProvider, child) {
            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
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
                    profileScreenProvider.SignOutProfile(context);
                  },
                  icon: const Icon(Icons.add_comment_rounded),
                  label: const Text('LogOut'),
                ),
                body: Form(
                  key: _formkey,
                  child: Padding(
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
                                _image != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(70)),
                                        child: Image.file(
                                        File(_image!),
                                          width:23,
                                          height:23,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(70)),
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
                                      onPressed: () {
                                        _showBottomSheet();
                                      },
                                      shape: const CircleBorder(),
                                      color: Colors.white,
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
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
                              onSaved: (val) => ApiService.me.name = val ?? '',
                              validator: (val) => val != null && val.isNotEmpty
                                  ? null
                                  : 'Required field',
                              decoration: InputDecoration(
                                  hintText: eg,
                                  label: const Text(name),
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
                              onSaved: (val) => ApiService.me.about = val ?? '',
                              validator: (val) => val != null && val.isNotEmpty
                                  ? null
                                  : 'Required field',
                              decoration: InputDecoration(
                                  hintText: feeling,
                                  label: const Text(about),
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
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  ApiService.updateUserInfo()
                                      .then((value) => const Dialog(
                                            child: Text('Update Successfully'),
                                          ));
                                }
                              },
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
                  ),
                ));
          }),
        ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: MediaQuery.of(context).size.height * 0.04),
                child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pick profile image',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * .3,
                            MediaQuery.of(context).size.height * .15,
                          )),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
// Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          log('Image Path:${image.path}--MineType:${image.mimeType}');
                          setState(() {
                            _image=image.path;
                          });
                          
                        }
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/album.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * .3,
                              MediaQuery.of(context).size.height * .15)),
                      onPressed: () async{
                        final ImagePicker picker = ImagePicker();
// Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);

                        if (image != null) {
                          log('Image Path:${image.path}');
                          setState(() {
                            _image=image.path;
                          });

                        }
                      },
                      child: Image.asset('assets/images/camera.png'))
                ],
              )
            ],
          );
        });
  }
}
