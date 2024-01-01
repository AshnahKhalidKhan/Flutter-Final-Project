import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget 
{
  final String pagename;
  const MyAppBar({Key? key, required this.pagename}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return AppBar
    (
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: Builder
      (
        builder: (BuildContext context) 
        {
          return IconButton
          (
            icon: const Icon(Icons.menu_rounded),
            color: Colors.white,
            onPressed: () 
            {
              Scaffold.of(context).openDrawer();
            },
          );
        }
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