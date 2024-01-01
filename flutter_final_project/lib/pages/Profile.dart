import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/blocs/theme_color_picker/theme_color_bloc.dart';
import 'package:flutter_final_project/blocs/theme_color_picker/theme_color_events.dart';
import 'package:flutter_final_project/main.dart';
import 'package:flutter_final_project/reusable_widgets_constants/drawer.dart';

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
      drawer: MyDrawer(),
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
