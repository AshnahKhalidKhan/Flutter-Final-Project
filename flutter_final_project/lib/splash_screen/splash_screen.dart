import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget 
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
{
  @override
  void initState() 
  {
    super.initState();
    Timer
    (
      Duration(seconds: 5), () => Navigator.pushReplacementNamed
      (
        context,
        '/LoginSignUp',
      ));
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: Center
      (
        child: Image.asset
        (
          'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png'
        ),
      ),
    );
  }
}
