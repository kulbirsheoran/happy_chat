import 'package:flutter/material.dart';
import 'package:happy_chat/ui/const/string_const.dart';

Widget position1(context) {
  bool isAnimated = false;

  return  AnimatedPositioned(
        duration: const Duration(seconds: 2),
        top: MediaQuery.of(context).size.height * .15,
        left:  MediaQuery.of(context).size.width*25,
       right: isAnimated ? MediaQuery.of(context).size.width * .25:MediaQuery.of(context).size.width*.25,
        width: MediaQuery.of(context).size.width*.5,
        child: Image.asset(
          'assets/images/chat_img.png',
          width: 150,
        ),
  );
}

Widget position2(context,{required onPress}) {
  return Positioned(

      bottom: MediaQuery.of(context).size.height * .15,
      left: MediaQuery.of(context).size.width * 0.05,
      width: MediaQuery.of(context).size.width * .9,

      height: MediaQuery.of(context).size.width * .15,

      child: ElevatedButton.icon(
        onPressed: () {

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
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
