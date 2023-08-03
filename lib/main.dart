import 'package:flutter/material.dart';
import 'package:happy_chat/ui/auth/login_screen.dart';
import 'package:happy_chat/ui/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
     debugShowCheckedModeBanner: false,
        //title: 'Happy Chat',

      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black,
                fontSize: 16,
              //  fontWeight: FontWeight.normal,
             // backgroundColor: Colors.white
            ),

        )
      ),



      color: Colors.white,
      home: LoginScreen(),
    );
  }
}


