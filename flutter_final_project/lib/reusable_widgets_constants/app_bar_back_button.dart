import 'package:flutter/material.dart';

class MyBackButtonAppBar extends StatelessWidget implements PreferredSizeWidget
{
  final String pagename;
  const MyBackButtonAppBar({Key? key, required this.pagename}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) 
  {
    return AppBar
    (
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: BackButton
      (
        color: Colors.white,
        onPressed: () 
        {
          Navigator.of(context).pop();
        },
      ),
      title: Text
      (
        pagename,
        style: const TextStyle
        (
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
    );
  }
}