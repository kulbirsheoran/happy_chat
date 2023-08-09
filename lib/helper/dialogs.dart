

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Dialogs{
//   static void showSnackbar( context,String msg,){
//     ScaffoldMessenger.of(context);showSnackbar(SnackBar(content: Text(msg)) );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackbar( context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  static void showProgressBar(context,){
    showDialog(context: context, builder: (_)=>const Center(child: CircularProgressIndicator()));
  }
}
