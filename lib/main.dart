import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:orix_aqua_adim/ui/dashboard/dashboard.dart';
import 'package:orix_aqua_adim/ui/login%20page/loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Sen',
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: AnimatedSplashScreen(
          splash: Center(
            child: Image.asset("assets/images/a3.jpg",
              height: 300,width: 300,),
          ),
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: LoginScreen(),
          splashIconSize: 200,
          backgroundColor: Colors.white,
          duration: 1500,
          animationDuration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }
}


