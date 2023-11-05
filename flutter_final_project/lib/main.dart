import 'package:flutter/material.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Experimenting With Themes',
      theme: ThemeData
      (
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: TextTheme
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
        appBarTheme: AppBarTheme
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
      home: TabBarExample(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

