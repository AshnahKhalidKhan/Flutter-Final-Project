import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget
{
  final String snackBarMessage;
  const MySnackBar({Key? key, required this.snackBarMessage}) : super(key: key);


  @override
  Widget build(BuildContext context) 
  {
    return SnackBar
    (
      content: Text
      (
        snackBarMessage,
        style: const TextStyle
        (
          color: Colors.white,
          fontSize: 20.0
        ),
      ),
    );
  }
}