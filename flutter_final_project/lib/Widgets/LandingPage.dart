// import 'package:flutter/material.dart';
// import 'package:flutter_final_project/sign_in_sign_up/sign_in_sign_up.dart';
// import 'package:flutter_final_project/Widgets/ActivityCalendar.dart';
// import 'package:flutter_final_project/Widgets/DiscussionsList.dart';
// import 'package:flutter_final_project/Widgets/EventsList.dart';
// import 'package:flutter_final_project/Widgets/Profile.dart';
// import 'package:flutter_final_project/Widgets/RegistrationsList.dart';
// import 'package:flutter_final_project/main.dart';

// class LandingPage extends StatefulWidget 
// {
//   const LandingPage({super.key});
//   // static const routeName = '/extractArguments';

//   @override
//   State<LandingPage> createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> 
// {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) 
//   {
//     // final args = ModalRoute.of(context)!.settings.arguments as ScreenArgumentsNeededToPass;
    
//     return Scaffold
//     (
//       bottomNavigationBar: BottomNavigationBar
//       (
//         useLegacyColorScheme: false,
//         type: BottomNavigationBarType.fixed,
//         showUnselectedLabels: true,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         selectedIconTheme: IconThemeData
//         (
//           // color: Theme.of(context).colorScheme.primary,
//           color: Colors.white
//         ),
//         selectedLabelStyle: TextStyle
//         (
//           // color: Theme.of(context).colorScheme.primary,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 15.0
//         ),
//         unselectedIconTheme: IconThemeData
//         (
//           color: Colors.white
//         ),
//         unselectedLabelStyle: TextStyle
//         (
//           color: Colors.white,
//         ),
//         items: <BottomNavigationBarItem>
//         [
//           BottomNavigationBarItem
//           (
//             label: 'Actviity Calendar',
//             icon: Badge
//             (
//               isLabelVisible: false,
//               child: Icon
//               (
//                 Icons.calendar_month_rounded,
//                 // color: Colors.white,
//               ),
//             ),
//           ),
//           BottomNavigationBarItem
//           (
//             label: 'Events',
//             icon: Badge
//             (
//               isLabelVisible: false,
//               child: Icon
//               (
//                 Icons.event_note_rounded,
//               ),
//             ),
//           ),
//           BottomNavigationBarItem
//           (
//             label: 'Discussions',
//             icon: Badge
//             (
//               isLabelVisible: false,
//               child: Icon
//               (
//                 Icons.message_rounded,
//                 // color: Colors.white,
//               ),
//             ),
//           ),
//           BottomNavigationBarItem
//           (
//             label: 'Profile',
//             icon: Badge
//             (
//               isLabelVisible: false,
//               child: Icon
//               (
//                 Icons.person_2_rounded,
//               ),
//             ),
//           ),
//         ],
//         currentIndex: currentPageIndex,
//         onTap: (index)
//         {
//           setState(() 
//           {
//             currentPageIndex = index;
//           });
//         },
//       ),
//       body: <Widget>
//       [
//         ActivityCalendar(),
//         EventsList(),
//         DiscussionsList(),
//         Profile(),
//       ][currentPageIndex],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_final_project/sign_in_sign_up/sign_in_sign_up.dart';
import 'package:flutter_final_project/Widgets/ActivityCalendar.dart';
import 'package:flutter_final_project/Widgets/DiscussionsList.dart';
import 'package:flutter_final_project/Widgets/EventsList.dart';
import 'package:flutter_final_project/Widgets/Profile.dart';
import 'package:flutter_final_project/Widgets/RegistrationsList.dart';
import 'package:flutter_final_project/main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Activity Calendar',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.calendar_month_rounded,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Events',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.event_note_rounded,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Discussions',
            icon: Badge(
              isLabelVisible: false,
              child: Icon(
                Icons.message_rounded,
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
            // Update here to navigate to '/EventsList'
            switch (index) {
              case 0:
              Navigator.pushNamed(context, '/ActivityCalendar');
                // Navigate to ActivityCalendar
                break;
              case 1:
                // Navigate to EventsList using named route
                Navigator.pushNamed(context, '/EventsList');
                break;
              case 2:
              Navigator.pushNamed(context, '/ActivityCalendar');
                // Navigate to DiscussionsList
                break;
              case 3:
              Navigator.pushNamed(context, '/ActivityCalendar');
                // Navigate to Profile
                break;
            }
          });
        },
      ),
      body: <Widget>[
        ActivityCalendar(),
        EventsList(),
        DiscussionsList(),
        Profile(),
      ][currentPageIndex],
    );
  }
}
