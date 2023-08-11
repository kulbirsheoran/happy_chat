

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:happy_chat/ui/auth/login_screen.dart';
import 'package:happy_chat/ui/const/string_const.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3),(){
 if(FirebaseAuth.instance.currentUser!=null){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));

 }else{
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

 }

  }
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Positioned(

              bottom: MediaQuery.of(context).size.height * .5,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.width * .15,
              child:
             Image.asset('assets/images/chat_img.png',width: 150,height: 150,),
          ),
      Positioned(

      bottom: MediaQuery.of(context).size.height * .15,
        left: MediaQuery.of(context).size.width * .4,
        width: MediaQuery.of(context).size.width * .9,
        //right: MediaQuery.of(context).size.width*.1,
        height: MediaQuery.of(context).size.width * .15,
        // width: MediaQuery.of(context).size.width,
        child:
          const Text(madeBy)
    ),
        ],
      )
    );
  }
}
