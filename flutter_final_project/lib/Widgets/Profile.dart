import 'package:flutter/material.dart';

class Profile extends StatefulWidget 
{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> 
{
  double blueProfileButtonSize = 30.0;
  double redProfileButtonSize = 30.0;
  double yellowProfileButtonSize = 30.0;
  double greenProfileButtonSize = 30.0;

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
                  radius: blueProfileButtonSize,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  child: GestureDetector
                  (
                    onTap: ()
                    {
                      setState(() 
                      {
                        blueProfileButtonSize = 40.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 20.0;
                      });
                    }
                  ),
                ),
                CircleAvatar
                (
                  radius: redProfileButtonSize,
                  backgroundColor: Colors.red,
                  child: GestureDetector
                  (
                    onTap: ()
                    {
                      setState(() 
                      {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 40.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 20.0;
                      });
                    }
                  ),
                ),
                CircleAvatar
                (
                  radius: yellowProfileButtonSize,
                  backgroundColor: Colors.amber,
                  child: GestureDetector
                  (
                    onTap: ()
                    {
                      setState(() 
                      {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 40.0;
                        greenProfileButtonSize = 20.0;
                      });
                    }
                  ),
                ),
                CircleAvatar
                (
                  radius: greenProfileButtonSize,
                  backgroundColor: Colors.green,
                  child: GestureDetector
                  (
                    onTap: ()
                    {
                      setState(() 
                      {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 40.0;
                      });
                    }
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}