import 'package:flutter/material.dart';
import 'package:flutter_final_project/pages/sign_in_sign_up.dart';
import 'package:flutter_final_project/pages/admins_list.dart';
import 'package:flutter_final_project/pages/campuses_list.dart';
import 'package:flutter_final_project/pages/leads_list.dart';
import 'package:flutter_final_project/pages/profile.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedIconTheme: IconThemeData(
            // color: Theme.of(context).colorScheme.primary,
            color: Colors.white),
        selectedLabelStyle: TextStyle(
            // color: Theme.of(context).colorScheme.primary,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Campuses',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.school_rounded,
                // color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Leads',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.star_rounded,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Admins',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.admin_panel_settings_rounded,
                // color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.person_2_rounded,
              ),
            ),
          ),
        ],
        currentIndex: currentPageIndex,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: <Widget>[
        CampusesList(),
        LeadsList(),
        AdminsList(),
        Profile(),
      ][currentPageIndex],
    );
  }
}
