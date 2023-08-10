
import 'package:flutter/material.dart';
import 'package:happy_chat/provider/login_provider.dart';
import 'package:happy_chat/ui/const/string_const.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () {
      Provider.of<loginScreenProvider>(context, listen: false)
          .iconAnimation(true);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(welcome),
      ),
      body: Consumer<loginScreenProvider>(
        builder: ((context, animationProvider, child) {
          final isAnimated = animationProvider.isAnimated;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(seconds: 2),
                top: MediaQuery.of(context).size.height * .13,
                // left: MediaQuery.of(context).size.width * 25,
                right: isAnimated
                    ? MediaQuery.of(context).size.width * .25
                    : -MediaQuery.of(context).size.width * .25,
                //right:isAnimated ? MediaQuery.of(context).size.width * .30:MediaQuery.of(context).size.width * .30,
                width: MediaQuery.of(context).size.width * .5,
                // width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/chat_img.png',
                  width: 150,
                ),
              ),
              Positioned(
                  bottom: MediaQuery.of(context).size.height * .15,
                  left: MediaQuery.of(context).size.width * 0.05,
                  width: MediaQuery.of(context).size.width * .9,
                  //right: MediaQuery.of(context).size.width*.1,
                  height: MediaQuery.of(context).size.width * .15,
                  // width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      animationProvider.handleGoogleBtnClick(context);

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
                      TextSpan(
                          text: google,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ])),
                  ))
            ],
          );
        }),
      ),
    );
  }
}
