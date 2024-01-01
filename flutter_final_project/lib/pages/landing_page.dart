import 'package:flutter/material.dart';
import 'package:flutter_final_project/pages/ActivityCalendar.dart';
import 'package:flutter_final_project/pages/DiscussionsList.dart';
import 'package:flutter_final_project/pages/EventsList.dart';
import 'package:flutter_final_project/pages/profile.dart';

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
        selectedIconTheme: const IconThemeData
        (
          color: Colors.white
        ),
        selectedLabelStyle: const TextStyle
        (
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.0
        ),
        unselectedIconTheme: const IconThemeData
        (
          color: Colors.white
        ),
        unselectedLabelStyle: const TextStyle
        (
          color: Colors.white,
        ),
        items: const <BottomNavigationBarItem>
        [
          BottomNavigationBarItem
          (
            label: 'Activities',
            icon: Badge
            (
              isLabelVisible: false,
              child: Icon
              (
                Icons.calendar_month_rounded,
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
      body: const <Widget>
      [
        ActivityCalendar(),
        EventsList(),
        DiscussionsList(),
        Profile(),
      ][currentPageIndex],
    );
  }
}
