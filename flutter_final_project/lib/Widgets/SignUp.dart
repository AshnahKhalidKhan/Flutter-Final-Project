/*

- Show no cross or tick initially when signing in screen loads first time (null in place of RedCroossIcon and )
- Visibility password on/off 
- Password requirements meeting state

*/


import 'package:flutter/material.dart';

class SignUp extends StatefulWidget 
{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> 
{
  Icon GreenCheckIcon = Icon
  (
    Icons.check_circle_rounded,
    color: Colors.green,
  );

  Icon RedCrossIcon = Icon
  (
    Icons.cancel_rounded,
    color: Colors.red,
  );

  


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: EdgeInsets.all(30.0),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Image.asset
            (
              'lib/Assets/Google Pocket App Logo.jpg',
              width: 100,
              height: 100
            ),
            // RadioMenuButton
            // (
            //   value: Invalid, 
            //   groupValue: groupValue, 
            //   onChanged: onChanged, 
            //   child: child
            // ),
            TextField
            (
              decoration: InputDecoration
              (
                prefixIcon: Icon(Icons.person_2_rounded),
                labelText: 'Full Name',
                helperText: 'each word must be capitalized',
                suffixIcon: RedCrossIcon,
              ),
            ),
            TextField
            (
              decoration: InputDecoration
              (
                prefixIcon: Icon(Icons.email_rounded),
                labelText: 'Email',
                helperText: 'Helper text',
                errorText: 'Error text',
                suffixIcon: RedCrossIcon,
              ),
            ),
            TextField
            (
              obscureText: true,
              decoration: InputDecoration
              (
                prefixIcon: Icon(Icons.key_rounded),
                labelText: 'Password',
                suffixIcon: Icon(Icons.visibility),
                error: Column
                (
                  children: 
                  [
                    Row
                    (
                      children: 
                      [
                        GreenCheckIcon,
                        RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Minimum 8 characters'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        GreenCheckIcon,
                        RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one uppercase alphabet (A-Z)'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        
                        GreenCheckIcon,
                        RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one digit (0-9)'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        GreenCheckIcon,
                        RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one special character (!, @, #...)'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            TextField
            (
              obscureText: true,
              decoration: InputDecoration
              (
                prefixIcon: Icon(Icons.key_rounded),
                labelText: 'Confirm Password',
                suffixIcon: RedCrossIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}