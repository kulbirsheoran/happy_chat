import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:happy_chat/provider/profile_provider.dart';
import 'package:happy_chat/provider/login_provider.dart';

import 'package:happy_chat/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (error) {
    print("Firebase initialization error: $error");
  }// Ensure that Flutter is initialized
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context)=>loginScreenProvider()),
        ChangeNotifierProvider(create: (context)=>ProfileScreenProvider()),
      ],
      child: MaterialApp(
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
        home: SplashScreen(),
      ),
    );
  }
}


