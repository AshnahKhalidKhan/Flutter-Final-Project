

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/Widgets/SignUp.dart';

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
      Duration(seconds: 3), () => 
      Navigator.of(context).pushReplacement
      (
        MaterialPageRoute(builder: (BuildContext context) => SignUp())
      )
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: Center
      (
        child: Image.asset('lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png'),
      ),
    );
  }
}