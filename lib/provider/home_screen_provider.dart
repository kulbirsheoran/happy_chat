//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:happy_chat/model/chat_user.dart';
//
// class HomeScreenProvider extends ChangeNotifier {
//
//   bool _isSearching = false;
//   List<ChatUser> searchList = [];
//   List<ChatUser> list = [];
//
//
//   search() {
//
//
//   }
// }
import 'package:flutter/material.dart';
import 'package:happy_chat/model/chat_user.dart';

class HomeScreenProvider extends ChangeNotifier {
  bool _isSearching = false;
  List<ChatUser> searchList = [];
  List<ChatUser> list = [];

  bool get isSearching => _isSearching;

  void isSearch() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void search(String query) {

    searchList.clear();
    for (var user in list) {

      if (user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase())) {
        searchList.add(user);

      }
    }
    notifyListeners();
  }

}
