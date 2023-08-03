import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';

Widget position1(context) {
  bool _isAnimated = false;
  return AnimatedPositioned(
      duration: Duration(seconds: 2),
      top: MediaQuery.of(context).size.height * .15,
     // left: MediaQuery.of(context).size.width * .30,
      right:_isAnimated ? MediaQuery.of(context).size.width * .30:MediaQuery.of(context).size.width * .30,
      width: MediaQuery.of(context).size.width*.5,
      // width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/chat_img.png',
        width: 150,
      ));
}

Widget position2(context) {
  return Positioned(

      bottom: MediaQuery.of(context).size.height * .15,
      left: MediaQuery.of(context).size.width * 0.05,
      width: MediaQuery.of(context).size.width * .9,
      //right: MediaQuery.of(context).size.width*.1,
      height: MediaQuery.of(context).size.width * .15,
      // width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: const StadiumBorder(),
            elevation: 1),
        icon: Image.asset(
          'assets/images/google_img.jpg',
        ),
        label: RichText(
            text: const TextSpan(children: [
          TextSpan(text: signInWith),
          TextSpan(text: google, style: TextStyle(fontWeight: FontWeight.bold)),
        ])),
      ));
}