





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_chat/helper/dialogs.dart';
import 'package:happy_chat/ui/auth/login_screen.dart';

class ProfileScreenProvider extends ChangeNotifier{

      void SignOutProfile( context)async{


        Dialogs.showProgressBar(context,);
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut().then((value) {
          Navigator.pop( context );
          Navigator.pushReplacement(
             context  ,
              MaterialPageRoute(
                  builder: (context) => const LoginScreen()));

           notifyListeners();
        });

      }
}