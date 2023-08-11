import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happy_chat/service/firebase_service.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';

import '../helper/dialogs.dart';

class loginScreenProvider extends ChangeNotifier {
  bool _isAnimated = false;

  bool get isAnimated => _isAnimated;

  void iconAnimation(bool value) {
    _isAnimated = value;

    notifyListeners();
  }

  handleGoogleBtnClick(context) async {
    Dialogs.showProgressBar(context);
    _signInWithGoogle(context).then((user) async {
      //hide progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo:${user.additionalUserInfo}');

        if (await ApiService.userExists()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          await ApiService.createUser().then((value) =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
          );
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle(context) async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle:$e');
      Dialogs.showSnackbar(context, 'something went wrong');
      return null;
    }
  }
// signOut()async{
// await FirebaseAuth.instance.signOut();
// await GoogleSignIn().signOut();
// }
}
