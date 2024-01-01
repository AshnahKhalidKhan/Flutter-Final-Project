import 'package:flutter/material.dart';

SnackBar MySnackBar(String snackBarMessage)
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