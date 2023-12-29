import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/AuthenticationFlowScreen.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/EventsListBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListBloc.dart';
import 'package:flutter_final_project/Blocs/ThemeColorBloc.dart';
import 'package:flutter_final_project/Blocs/ThemeColorEvents.dart';
import 'package:flutter_final_project/Blocs/ThemeColorStates.dart';
import 'package:flutter_final_project/Core/Repositories/AuthenticationRepository.dart';
import 'package:flutter_final_project/Core/Repositories/EventsListRepository.dart';
import 'package:flutter_final_project/Core/Repositories/GDSCCampusesRepository.dart';
import 'package:flutter_final_project/Core/Repositories/GDSCLeadsMembersListRepository.dart';
import 'package:flutter_final_project/FinalSignInSignUpScreen.dart';
import 'package:flutter_final_project/Widgets/AdminHomepage.dart';
import 'package:flutter_final_project/Widgets/AdminLeadsApproval.dart';
import 'package:flutter_final_project/Widgets/AdminsList.dart';
import 'package:flutter_final_project/Widgets/GDSCCampusesList.dart';
import 'package:flutter_final_project/Widgets/GDSCLeadMembersPendingRequests.dart';
import 'package:flutter_final_project/Widgets/GDSCLeadPendingApproval.dart';
import 'package:flutter_final_project/Widgets/GDSCMembersPendingApproval.dart';
import 'package:flutter_final_project/Widgets/Gallery.dart';
import 'package:flutter_final_project/Widgets/LandingPage.dart';
import 'package:flutter_final_project/Widgets/Profile.dart';
import 'package:flutter_final_project/Widgets/RegistrationsList.dart';
import 'package:flutter_final_project/Widgets/SignUp.dart';
import 'package:flutter_final_project/Widgets/SplashScreen.dart';
import 'package:flutter_final_project/firebase_options.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

const Color GoogleBlue = Color(0xFF4285F4);
const Color GoogleRed = Color(0xFFEA4335);
const Color GoogleYellow = Color(0xFFFBBC04);
const Color GoogleGreen = Color(0xFF34A853);
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp
  (
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});
  
  static const Color GoogleBlue = Color(0xFF4285F4);
  static const Color GoogleRed = Color(0xFFEA4335);
  static const Color GoogleYellow = Color(0xFFFBBC04);
  static const Color GoogleGreen = Color(0xFF34A853);

  @override
  Widget build(BuildContext context) 
  {
    return MultiRepositoryProvider
    (
      providers: 
      [
        RepositoryProvider<AuthenticationRepository>
        (
          create: (context) => AuthenticationRepository
          (
            firebaseAuth: _firebaseAuth,
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        RepositoryProvider<GDSCCampusesRepository>
        (
          create: (context) => GDSCCampusesRepository
          (
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        RepositoryProvider<GDSCLeadsMembersListRepository>
        (
          create: (context) => GDSCLeadsMembersListRepository
          (
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        RepositoryProvider<EventsListRepository>
        (
          create: (context) => EventsListRepository
          (
            firebaseFirestore: _firebaseFirestore,
          ),
        ),
        // RepositoryProvider<UserRepository>
        // (
        //   create: (context) =>
        //       UserRepository(_firebaseFirestore, _firebaseAuth),
        // ),
      ],
      child: MultiBlocProvider
      (
        providers: 
        [
          BlocProvider<AuthenticationBloc>
          (
            create: (context) => AuthenticationBloc
            (
              authenticationRepository: context.read<AuthenticationRepository>()
            ),
          ),
          BlocProvider<GDSCCampusesBloc>
          (
            create: (context) => GDSCCampusesBloc
            (
              campussRepository: context.read<GDSCCampusesRepository>()
            ),
          ),
          BlocProvider<GDSCLeadsMembersListBloc>
          (
            create: (context) => GDSCLeadsMembersListBloc
            (
              gDSCLeadsMembersRepository: context.read<GDSCLeadsMembersListRepository>()
            ),
          ),
          BlocProvider<ThemeColorBloc>
          (
            create: (context) => ThemeColorBloc
            (
              //Nothing inside??????
            ),
          ),
          BlocProvider<EventsListBloc>
          (
            create: (context) => EventsListBloc
            (
              eventListRepository: context.read<EventsListRepository>()
            ),
          ),
        ],
        child: BlocBuilder<ThemeColorBloc, ThemeColorState>
        (
          builder: (context, state)
          {
            if (state is ThemeColorChangedState)
            {
              return MaterialApp
              (
                title: 'Experimenting With Themes',
                theme: ThemeData
                (
                  useMaterial3: true,
                  brightness: Brightness.light,
                  textTheme: const TextTheme
                  (
                  ),
                  appBarTheme: const AppBarTheme
                  (
                  ),
                  colorScheme: ColorScheme.fromSeed(seedColor: state.color),
                  iconButtonTheme: const IconButtonThemeData
                  (
                    style: ButtonStyle
                    (
                      iconSize: MaterialStatePropertyAll(30.0)
                    )
                  ),
                ),
                initialRoute: '/',
                routes: 
                {
                  '/': (context) => SplashScreen(),
                  '/LoginSignUp': (context) => const FinalSignInSignUp(),
                  '/GDSCMembersPendingRequest': (context) => const GDSCMembersPendingRequest(),
                  '/GDSCLeadPendingRequest': (context) => const GDSCLeadPendingRequest(),
                  '/HomePage': (context) => const LandingPage(),
                  '/AdminHomePage': (context) => const AdminHomePage(),
                  '/CampusesList': (context) => const GDSCCampusesList(),
                  '/GDSCLeadsPendingApprovalsList': (context) => const GDSCLeadMembersPendingRequests(),
                  '/AdminsList': (context) => const AdminsList(),
                  '/Profile': (context) => const Profile(),
                  // '/SignIn': (context) => const SignIn(),
                  // '/AdminUsers': (context) => const AdminUsers(), //All Admin Users CRUD thingies
                  // '/AddGDSCCampus': (context) => const AddGDSCCampus(),
              
                  
                  // '/PageName': (context) => const PageName(),
                  // '/PageName': (context) => const PageName(),
                  // '/PageName': (context) => const PageName(),
                }
                // home: TabBarExample(),
                // home: const MyHomePage(title: 'Flutter Demo Home Page'),
                // home: DatePickerExample(),
                // home: PopupMenuExample(),
                // home: RadioExample(),
                // home: SliderExample(),
                // home: SwitchExample(),
                // home: ShowTimePickerApp(),
                // home: TimePickerOptions(),
                // home: SignUp(),
                // home: Gallery(),
                // home: Profile()
                // home: GDSCLeadsApproval()
                // home: const AuthenticationFlowScreen()
                // home: MyHomePage(title: 'Hellow?')
                // home: RegistrationsList()
                // home: LandingPage()
                // home: GDSCMembersPendingRequest()
                // home: GDSCLeadPendingRequest()
              );
            }
            else
            {
              return MaterialApp
              (
                title: 'Experimenting With Themes',
                theme: ThemeData
                (
                  useMaterial3: true,
                  brightness: Brightness.light,
                  textTheme: const TextTheme
                  (
                    // TextStyle? displayLarge,
                    // TextStyle? displayMedium,
                    // TextStyle? displaySmall,
                    // TextStyle? headlineLarge,
                    // TextStyle? headlineMedium,
                    // TextStyle? headlineSmall,
                    // TextStyle? titleLarge,
                    // TextStyle? titleMedium,
                    // TextStyle? titleSmall,
                    // TextStyle? bodyLarge,
                    // TextStyle? bodyMedium,
                    // TextStyle? bodySmall,
                    // TextStyle? labelLarge,
                    // TextStyle? labelMedium,
                    // TextStyle? labelSmall,
                    // TextStyle? headline1,
                    // TextStyle? headline2,
                    // TextStyle? headline3,
                    // TextStyle? headline4,
                    // TextStyle? headline5,
                    // TextStyle? headline6,
                    // TextStyle? subtitle1,
                    // TextStyle? subtitle2,
                    // TextStyle? bodyText1,
                    // TextStyle? bodyText2,
                    // TextStyle? caption,
                    // TextStyle? button,
                    // TextStyle? overline,
                  ),
                  appBarTheme: const AppBarTheme
                  (
                    // Color? color,
                    // Color? backgroundColor,
                    // Color? foregroundColor,
                    // double? elevation,
                    // double? scrolledUnderElevation,
                    // Color? shadowColor,
                    // Color? surfaceTintColor,
                    // ShapeBorder? shape,
                    // IconThemeData? iconTheme,
                    // IconThemeData? actionsIconTheme,
                    // bool? centerTitle,
                    // double? titleSpacing,
                    // double? toolbarHeight,
                    // TextStyle? toolbarTextStyle,
                    // TextStyle? titleTextStyle,
                    // SystemUiOverlayStyle? systemOverlayStyle,
                  ),
                  colorScheme: ColorScheme.fromSeed(seedColor: GoogleRed),
                  // bool? applyElevationOverlayColor,
                  // NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
                  // Iterable<ThemeExtension<dynamic>>? extensions,
                  // InputDecorationTheme? inputDecorationTheme,
                  // MaterialTapTargetSize? materialTapTargetSize,
                  // PageTransitionsTheme? pageTransitionsTheme,
                  // TargetPlatform? platform,
                  // ScrollbarThemeData? scrollbarTheme,
                  // InteractiveInkFeatureFactory? splashFactory,
                  // bool? useMaterial3,
                  // VisualDensity? visualDensity,
                  // Brightness? brightness,
                  // Color? canvasColor,
                  // Color? cardColor,
                  // ColorScheme? colorScheme,
                  // Color? colorSchemeSeed,
                  // Color? dialogBackgroundColor,
                  // Color? disabledColor,
                  // Color? dividerColor,
                  // Color? focusColor,
                  // Color? highlightColor,
                  // Color? hintColor,
                  // Color? hoverColor,
                  // Color? indicatorColor,
                  // Color? primaryColor,
                  // Color? primaryColorDark,
                  // Color? primaryColorLight,
                  // MaterialColor? primarySwatch,
                  // Color? scaffoldBackgroundColor,
                  // Color? secondaryHeaderColor,
                  // Color? shadowColor,
                  // Color? splashColor,
                  // Color? unselectedWidgetColor,
                  // String? fontFamily,
                  // List<String>? fontFamilyFallback,
                  // String? package,
                  // IconThemeData? iconTheme,
                  // IconThemeData? primaryIconTheme,
                  // TextTheme? primaryTextTheme,
                  // TextTheme? textTheme,
                  // Typography? typography,
                  // ActionIconThemeData? actionIconTheme,
                  // AppBarTheme? appBarTheme,
                  // BadgeThemeData? badgeTheme,
                  // MaterialBannerThemeData? bannerTheme,
                  // BottomAppBarTheme? bottomAppBarTheme,
                  // BottomNavigationBarThemeData? bottomNavigationBarTheme,
                  // BottomSheetThemeData? bottomSheetTheme,
                  // ButtonBarThemeData? buttonBarTheme,
                  // ButtonThemeData? buttonTheme,
                  // CardTheme? cardTheme,
                  // CheckboxThemeData? checkboxTheme,
                  // ChipThemeData? chipTheme,
                  // DataTableThemeData? dataTableTheme,
                  // DatePickerThemeData? datePickerTheme,
                  // DialogTheme? dialogTheme,
                  // DividerThemeData? dividerTheme,
                  // DrawerThemeData? drawerTheme,
                  // DropdownMenuThemeData? dropdownMenuTheme,
                  // ElevatedButtonThemeData? elevatedButtonTheme,
                  // ExpansionTileThemeData? expansionTileTheme,
                  // FilledButtonThemeData? filledButtonTheme,
                  // FloatingActionButtonThemeData? floatingActionButtonTheme,
                  // IconButtonThemeData? iconButtonTheme,
                  iconButtonTheme: const IconButtonThemeData
                  (
                    style: ButtonStyle
                    (
                      iconSize: MaterialStatePropertyAll(30.0)
                    )
                  ),
                  // ListTileThemeData? listTileTheme,
                  // MenuBarThemeData? menuBarTheme,
                  // MenuButtonThemeData? menuButtonTheme,
                  // MenuThemeData? menuTheme,
                  // NavigationBarThemeData? navigationBarTheme,
                  // NavigationDrawerThemeData? navigationDrawerTheme,
                  // NavigationRailThemeData? navigationRailTheme,
                  // OutlinedButtonThemeData? outlinedButtonTheme,
                  // PopupMenuThemeData? popupMenuTheme,
                  // ProgressIndicatorThemeData? progressIndicatorTheme,
                  // RadioThemeData? radioTheme,
                  // SearchBarThemeData? searchBarTheme,
                  // SearchViewThemeData? searchViewTheme,
                  // SegmentedButtonThemeData? segmentedButtonTheme,
                  // SliderThemeData? sliderTheme,
                  // SnackBarThemeData? snackBarTheme,
                  // SwitchThemeData? switchTheme,
                  // TabBarTheme? tabBarTheme,
                  // TextButtonThemeData? textButtonTheme,
                  // TextSelectionThemeData? textSelectionTheme,
                  // TimePickerThemeData? timePickerTheme,
                  // ToggleButtonsThemeData? toggleButtonsTheme,
                  // TooltipThemeData? tooltipTheme,
                  // AndroidOverscrollIndicator? androidOverscrollIndicator,
                  // Color? toggleableActiveColor,
                  // Color? selectedRowColor,
                  // Color? errorColor,
                  // Color? backgroundColor,
                  // Color? bottomAppBarColor,
                ),
                initialRoute: '/',
                routes: 
                {
                  '/': (context) => SplashScreen(),
                  '/LoginSignUp': (context) => const FinalSignInSignUp(),
                  '/GDSCMembersPendingRequest': (context) => const GDSCMembersPendingRequest(),
                  '/GDSCLeadPendingRequest': (context) => const GDSCLeadPendingRequest(),
                  '/HomePage': (context) => const LandingPage(),
                  '/AdminHomePage': (context) => const AdminHomePage(),
                  '/CampusesList': (context) => const GDSCCampusesList(),
                  '/GDSCLeadsPendingApprovalsList': (context) => const GDSCLeadMembersPendingRequests(),
                  '/AdminsList': (context) => const AdminsList(),
                  '/Profile': (context) => const Profile(),
                  // '/SignIn': (context) => const SignIn(),
                  // '/AdminUsers': (context) => const AdminUsers(), //All Admin Users CRUD thingies
                  // '/AddGDSCCampus': (context) => const AddGDSCCampus(),
              
                  
                  // '/PageName': (context) => const PageName(),
                  // '/PageName': (context) => const PageName(),
                  // '/PageName': (context) => const PageName(),
                }
                // home: TabBarExample(),
                // home: const MyHomePage(title: 'Flutter Demo Home Page'),
                // home: DatePickerExample(),
                // home: PopupMenuExample(),
                // home: RadioExample(),
                // home: SliderExample(),
                // home: SwitchExample(),
                // home: ShowTimePickerApp(),
                // home: TimePickerOptions(),
                // home: SignUp(),
                // home: Gallery(),
                // home: Profile()
                // home: GDSCLeadsApproval()
                // home: const AuthenticationFlowScreen()
                // home: MyHomePage(title: 'Hellow?')
                // home: RegistrationsList()
                // home: LandingPage()
                // home: GDSCMembersPendingRequest()
                // home: GDSCLeadPendingRequest()
              );
            }
          }
        ),
      )
    );
  }
}













class MyHomePage extends StatefulWidget 
{
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Calendar { day, week, month, year }

class _MyHomePageState extends State<MyHomePage> 
{
  int _counter = 0;

  void _incrementCounter() 
  {
    setState(() 
    {
      _counter++;
    });
  }
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(widget.title),
        actions: <Widget>
        [
          TextButton
          (
            onPressed: () {},
            child: const Text('Action 1'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // bottomNavigationBar: BottomAppBar
      // (
      //   shape: CircularNotchedRectangle(),
      //   child: Row
      //   (
      //     children: <Widget>
      //     [
      //       IconButton
      //       (
      //         tooltip: 'Open navigation menu',
      //         icon: const Icon(Icons.menu),
      //         onPressed: () {},
      //       ),
      //       IconButton
      //       (
      //         tooltip: 'Search',
      //         icon: const Icon(Icons.search),
      //         onPressed: () {},
      //       ),
      //       IconButton
      //       (
      //         tooltip: 'Favorite',
      //         icon: const Icon(Icons.favorite),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: NavigationBar
      (
        destinations: const <Widget>
        [
          NavigationDestination
          (
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination
          (
            icon: Icon(Icons.commute),
            label: 'Commute',
          ),
          NavigationDestination
          (
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
        ],
      ),
      body: Center
      (
        child: SingleChildScrollView
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [
              // child: Row
              // (
              //   children: <Widget>
              //   [
              //     NavigationRail
              //     (
              //       selectedIndex: 0,
              //       groupAlignment: -1.0,
              //       labelType: NavigationRailLabelType.all,
              //       leading: FloatingActionButton
              //       (
              //         elevation: 0,
              //         onPressed: () {},
              //         child: const Icon(Icons.add),
              //       ),
              //       trailing: IconButton
              //       (
              //         onPressed: () {},
              //         icon: const Icon(Icons.more_horiz_rounded),
              //       ),
              //       destinations: const <NavigationRailDestination>
              //       [
              //         NavigationRailDestination
              //         (
              //           icon: Icon(Icons.favorite_border),
              //           selectedIcon: Icon(Icons.favorite),
              //           label: Text('First'),
              //         ),
              //         NavigationRailDestination
              //         (
              //           icon: Icon(Icons.bookmark_border),
              //           selectedIcon: Icon(Icons.book),
              //           label: Text('Second'),
              //         ),
              //         NavigationRailDestination
              //         (
              //           icon: Icon(Icons.star_border),
              //           selectedIcon: Icon(Icons.star),
              //           label: Text('Third'),
              //         ),
              //       ],
              //     ),
              //     const VerticalDivider(thickness: 1, width: 1),
              //   ]
              // ),
              Chip
              (
                avatar: CircleAvatar
                (
                  child: const Text('AB'),
                ),
                label: const Text('Aaron Burr'),
              ),
              Checkbox
              (
                value: true, 
                onChanged: (bool? newValue) {},
              ),
              Checkbox
              (
                value: false, 
                onChanged: (bool? newValue) {},
              ),
              const Text
              (
                'You have pushed the button this many times:',
              ),
              Text
              (
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton
              (
                onPressed: () {}, 
                child: const Text('Elevated')
              ),
              const ElevatedButton
              (
                onPressed: null, 
                child: const Text('Elevated')
              ),
              FilledButton
              (
                onPressed: () {}, 
                child: const Text('Filled')
              ),
              const FilledButton
              (
                onPressed: null, 
                child: const Text('Filled')
              ),
              FilledButton.tonal
              (
                onPressed: () {}, 
                child: const Text('Filled Tonal')
              ),
              const FilledButton.tonal
              (
                onPressed: null, 
                child: const Text('Filled Tonal')
              ),
              OutlinedButton
              (
                onPressed: () {}, 
                child: const Text('Outlined')
              ),
              const OutlinedButton
              (
                onPressed: null, 
                child: const Text('Outlined')
              ),
              TextButton
              (
                onPressed: () {}, 
                child: const Text('Text')
              ),
              const TextButton
              (
                onPressed: null, 
                child: const Text('Text')
              ),
              FloatingActionButton
              (
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              const FloatingActionButton
              (
                onPressed: null,
                child: const Icon(Icons.add),
              ),
              FloatingActionButton.extended
              (
                onPressed: () {},
                label: const Text('Add'),
                icon: const Icon(Icons.add),
              ),
              const FloatingActionButton.extended
              (
                onPressed: null,
                label: const Text('Add'),
                icon: const Icon(Icons.add),
              ),
              IconButton
              (
                icon: const Icon(Icons.volume_up),
                tooltip: 'Increase volume by 10',
                onPressed: () {},
              ),
              Ink
              (
                child: IconButton
                (
                  icon: const Icon(Icons.android),
                  onPressed: () {},
                ),
              ),
              Row
              (
                children: 
                [
                  IconButton
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: () {},
                  ),
                  const IconButton
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: null,
                  ),
                  IconButton
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                  IconButton
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                ],
              ),
              Row
              (
                children: 
                [
                  IconButton.filled
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: () {},
                  ),
                  const IconButton.filled
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: null,
                  ),
                  IconButton.filled
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.filled
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                  IconButton.filled
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.filled
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                ],
              ),
              Row
              (
                children: 
                [
                  IconButton.filledTonal
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: () {},
                  ),
                  const IconButton.filledTonal
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: null,
                  ),
                  IconButton.filledTonal
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.filledTonal
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                  IconButton.filledTonal
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.filledTonal
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                ],
              ),
              Row
              (
                children: 
                [
                  IconButton.outlined
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: () {},
                  ),
                  const IconButton.outlined
                  (
                    icon: const Icon(Icons.filter_drama), 
                    onPressed: null,
                  ),
                  IconButton.outlined
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.outlined
                  (
                    isSelected: true,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                  IconButton.outlined
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                  const IconButton.outlined
                  (
                    isSelected: false,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    onPressed: null,
                  ),
                ],
              ),
              SegmentedButton<Calendar>
              (
                segments: const <ButtonSegment<Calendar>>
                [
                  ButtonSegment<Calendar>
                  (
                    value: Calendar.day,
                    label: Text('Day'),
                    icon: Icon(Icons.calendar_view_day),
                  ),
                  ButtonSegment<Calendar>
                  (
                    value: Calendar.day,
                    label: Text('Week'),
                    icon: Icon(Icons.calendar_view_week),
                  ),  
                  ButtonSegment<Calendar>
                  (
                    value: Calendar.day,
                    label: Text('Month'),
                    icon: Icon(Icons.calendar_view_month),
                  ),
                  ButtonSegment<Calendar>
                  (
                    value: Calendar.day,
                    label: Text('Year'),
                    icon: Icon(Icons.calendar_today),
                  ),
                ],
                selected: <Calendar>{calendarView},
                onSelectionChanged: (Set<Calendar> newSelection) {},
              ),
              LinearProgressIndicator(),
              ElevatedButton
              (
                child: const Text('Show Snackbar'),
                onPressed: () 
                {
                  ScaffoldMessenger.of(context).showSnackBar
                  (
                    SnackBar
                    (
                      content: const Text('Awesome Snackbar!'),
                      action: SnackBarAction
                      (
                        label: 'Action',
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
              TextButton
              (
                onPressed: () => showDialog<String>
                (
                  context: context,
                  builder: (BuildContext context) => AlertDialog
                  (
                    title: const Text('AlertDialog Title'),
                    content: const Text('AlertDialog description'),
                    actions: <Widget>
                    [
                      TextButton
                      (
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton
                      (
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
              const Card
              (
                child: Text('Card'),
              ),
              const Card
              (
                child: Text('Card'),
                elevation: 0,
              ),
              const Divider(),
              ListTile
              (
                leading: Icon(Icons.alarm),
                title: Text('Title'),
                subtitle: Text('Subtitle Description'),
                trailing: Wrap
                (
                  // child: Row
                  // (
                  //   mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      Icon(Icons.edit),
                      Icon(Icons.delete),
                    ],
                  // ),
                ),
              ),
              SizedBox(height: 50.0,)

            ],
          ),
        ),
      ),
    );
  }
}

class TabBarExample extends StatefulWidget 
{
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> with TickerProviderStateMixin 
{
  late final TabController _tabController;

  @override
  void initState() 
  {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() 
  {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('TabBar Sample'),
        bottom: TabBar
        (
          controller: _tabController,
          tabs: const <Widget>
          [
            Tab
            (
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab
            (
              icon: Icon(Icons.beach_access_sharp),
            ),
            Tab
            (
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView
      (
        controller: _tabController,
        children: const <Widget>
        [
          Center
          (
            child: Text("It's cloudy here"),
          ),
          Center
          (
            child: Text("It's rainy here"),
          ),
          Center
          (
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}

class DatePickerExample extends StatefulWidget 
{
  const DatePickerExample({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DatePickerExampleState extends State<DatePickerExample> with RestorationMixin 
{
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>
  (
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) 
    {
      return navigator.restorablePush
      (
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute
  (
    BuildContext context,
    Object? arguments,
  )
  {
    return DialogRoute<DateTime>
    (
      context: context,
      builder: (BuildContext context) 
      {
        return DatePickerDialog
        (
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) 
  {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) 
  {
    if (newSelectedDate != null) 
    {
      setState(() 
      {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar
        (
          SnackBar
          (
            content: Text('Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
          )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: OutlinedButton
        (
          onPressed: () 
          {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Open Date Picker'),
        ),
      ),
    );
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuExample extends StatefulWidget 
{
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> 
{
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('PopupMenuButton')
      ),
      body: Center
      (
        child: PopupMenuButton<SampleItem>
        (
          initialValue: selectedMenu,
          // Callback that sets the selected popup menu item.
          onSelected: (SampleItem item) 
          {
            setState(() 
            {
              selectedMenu = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>
          [
            const PopupMenuItem<SampleItem>
            (
              value: SampleItem.itemOne,
              child: Text('Item 1'),
            ),
            const PopupMenuItem<SampleItem>
            (
              value: SampleItem.itemTwo,
              child: Text('Item 2'),
            ),
            const PopupMenuItem<SampleItem>
            (
              value: SampleItem.itemThree,
              child: Text('Item 3'),
            ),
          ],
        ),
      ),
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class RadioExample extends StatefulWidget 
{
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> 
{
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: Column
        (
          children: <Widget>
          [
            ListTile
            (
              title: const Text('Lafayette'),
              leading: Radio<SingingCharacter>
              (
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) 
                {
                  setState(() 
                  {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile
            (
              title: const Text('Thomas Jefferson'),
              leading: Radio<SingingCharacter>
              (
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) 
                {
                  setState(() 
                  {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderExample extends StatefulWidget 
{
  const SliderExample({super.key});

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> 
{
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(title: const Text('Slider')),
      body: Slider
      (
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) 
        {
          setState(() 
          {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}

class SwitchExample extends StatefulWidget 
{
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> 
{
  bool light = true;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Center
      (
        child: Switch
        (
          // This bool value toggles the switch.
          value: light,
          onChanged: (bool value) 
          {
            // This is called when the user toggles the switch.
            setState(() 
            {
              light = value;
            });
          },
        ),
      ),
    );
  }
}

class TimePickerOptions extends StatefulWidget 
{
  const TimePickerOptions({super.key});

  @override
  State<TimePickerOptions> createState() => _TimePickerOptionsState();
}

class _TimePickerOptionsState extends State<TimePickerOptions> 
{
  TimeOfDay? selectedTime;
  Orientation? orientation;

  @override
  Widget build(BuildContext context) 
  {
    return Material
    (
      child: Column
      (
        children: <Widget>
        [
          SingleChildScrollView
          (
            scrollDirection: Axis.horizontal,
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Padding
                (
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton
                  (
                    child: const Text('Open time picker'),
                    onPressed: () async 
                    {
                      final TimeOfDay? time = await showTimePicker
                      (
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                        initialEntryMode: TimePickerEntryMode.dial,
                        orientation: orientation,
                      );
                      setState(() 
                      {
                        selectedTime = time;
                      });
                    },
                  ),
                ),
                if (selectedTime != null)
                  Text('Selected time: ${selectedTime!.format(context)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}