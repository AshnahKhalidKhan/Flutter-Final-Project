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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center
      (
        child: SingleChildScrollView
        (
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>
            [
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
                    label: Text('week'),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton
      (
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
