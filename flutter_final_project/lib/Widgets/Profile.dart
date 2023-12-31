import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/Blocs/ThemeColorBloc.dart';
import 'package:flutter_final_project/Blocs/ThemeColorEvents.dart';
import 'package:flutter_final_project/main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double blueProfileButtonSize = 30.0;
  double redProfileButtonSize = 30.0;
  double yellowProfileButtonSize = 30.0;
  double greenProfileButtonSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu_rounded),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            DrawerHeader(
              child: SizedBox(width: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png'),
                  fit: BoxFit.fitHeight,
                ),
                // gradient: LinearGradient(colors: [GoogleBlue, GoogleGreen, GoogleRed, GoogleYellow].toList())
              ),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return ListTile(
                  // shape: RoundedRectangleBorder
                  // (
                  //   side: BorderSide
                  //   (
                  //     color: Theme.of(context).colorScheme.primary,
                  //     width: 2.0,
                  //   ),
                  //   borderRadius: BorderRadius.circular(0.0)
                  // ),
                  // tileColor: Colors.white,
                  leading: Icon(Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.primary, size: 30.0),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationSignOutEvent());
                  },
                );
              },
              listener: (context, state) {
                if (state is AuthenticationInitialState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/LoginSignUp',
                    (route) => false,
                  );
                } else if (state is AuthenticationErrorState) {
                  final signOutErrorSnackBarMessage = SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(signOutErrorSnackBarMessage);
                }
              },
            )
          ],
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose theme',
                style: TextStyle(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: blueProfileButtonSize,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    child: GestureDetector(onTap: () {
                      setState(() {
                        blueProfileButtonSize = 40.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 20.0;
                      });
                      BlocProvider.of<ThemeColorBloc>(context)
                          .add(ChangeThemeColorEvent(GoogleBlue));
                    }),
                  ),
                  CircleAvatar(
                    radius: redProfileButtonSize,
                    backgroundColor: Colors.red,
                    child: GestureDetector(onTap: () {
                      setState(() {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 40.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 20.0;
                      });
                      BlocProvider.of<ThemeColorBloc>(context)
                          .add(ChangeThemeColorEvent(GoogleRed));
                    }),
                  ),
                  CircleAvatar(
                    radius: yellowProfileButtonSize,
                    backgroundColor: Colors.amber,
                    child: GestureDetector(onTap: () {
                      setState(() {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 40.0;
                        greenProfileButtonSize = 20.0;
                      });
                      BlocProvider.of<ThemeColorBloc>(context)
                          .add(ChangeThemeColorEvent(GoogleYellow));
                    }),
                  ),
                  CircleAvatar(
                    radius: greenProfileButtonSize,
                    backgroundColor: Colors.green,
                    child: GestureDetector(onTap: () {
                      setState(() {
                        blueProfileButtonSize = 20.0;
                        redProfileButtonSize = 20.0;
                        yellowProfileButtonSize = 20.0;
                        greenProfileButtonSize = 40.0;
                      });
                      BlocProvider.of<ThemeColorBloc>(context)
                          .add(ChangeThemeColorEvent(GoogleGreen));
                    }),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
