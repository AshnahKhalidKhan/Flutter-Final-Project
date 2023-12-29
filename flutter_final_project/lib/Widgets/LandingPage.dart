import 'package:flutter/material.dart';
import 'package:flutter_final_project/FinalSignInSignUpScreen.dart';
import 'package:flutter_final_project/HomeScreen.dart';
import 'package:flutter_final_project/NewSignUpScreen.dart';
import 'package:flutter_final_project/Widgets/DiscussionsList.dart';
import 'package:flutter_final_project/Widgets/EventsList.dart';
import 'package:flutter_final_project/Widgets/Profile.dart';
import 'package:flutter_final_project/Widgets/RegistrationsList.dart';
import 'package:flutter_final_project/Widgets/SignUp.dart';
import 'package:flutter_final_project/main.dart';

class LandingPage extends StatefulWidget 
{
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> 
{
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      bottomNavigationBar: BottomNavigationBar
      (
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedIconTheme: IconThemeData
        (
          // color: Theme.of(context).colorScheme.primary,
          color: Colors.white
        ),
        selectedLabelStyle: TextStyle
        (
          // color: Theme.of(context).colorScheme.primary,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.0
        ),
        unselectedIconTheme: IconThemeData
        (
          color: Colors.white
        ),
        unselectedLabelStyle: TextStyle
        (
          color: Colors.white,
        ),
        items: <BottomNavigationBarItem>
        [
          BottomNavigationBarItem
          (
            label: 'Actviity Calendar',
            icon: Badge
            (
              isLabelVisible: false,
              child: Icon
              (
                Icons.calendar_month_rounded,
                // color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem
          (
            label: 'Events',
            icon: Badge
            (
              isLabelVisible: false,
              child: Icon
              (
                Icons.event_note_rounded,
              ),
            ),
          ),
          BottomNavigationBarItem
          (
            label: 'Discussions',
            icon: Badge
            (
              isLabelVisible: false,
              child: Icon
              (
                Icons.message_rounded,
                // color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem
          (
            label: 'Profile',
            icon: Badge
            (
              isLabelVisible: false,
              child: Icon
              (
                Icons.person_2_rounded,
              ),
            ),
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (index)
        {
          setState(() 
          {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>
      [
        // RegistrationsList(),
        // EventsList(),
        // DiscussionsList(),
        // Profile(),
        SignUp(),
        EventsList(),
        // NewSignUpScreen(),
        // HomeScreen(),
        FinalSignInSignUp(),
        Profile(),
      ][currentPageIndex],
    );
  }
}