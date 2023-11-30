import 'package:flutter/material.dart';

class Profile extends StatefulWidget 
{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: BackButton(),
        title: Text('Profile'),
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: Column
        (
          children: 
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: 
              [
                CircleAvatar
                (
                  radius: 30.0,
                  backgroundColor: Colors.blue,
                ),
                CircleAvatar
                (
                  radius: 30.0,
                  backgroundColor: Colors.red,
                ),
                CircleAvatar
                (
                  radius: 30.0,
                  backgroundColor: Colors.amber,
                ),
                CircleAvatar
                (
                  radius: 30.0,
                  backgroundColor: Colors.green,
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}