

import 'package:flutter/material.dart';
import 'package:happy_chat/ui/const/images_const.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/widget/positon_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(welcome),
        ),
        body: Stack(
            children: [
            position1(context),
            position2(context),
    ],
    )
    ,
    );
  }
}
