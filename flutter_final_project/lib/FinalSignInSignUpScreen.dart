import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesStates.dart';
import 'package:flutter_final_project/HomeScreen.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';

class FinalSignInSignUp extends StatefulWidget 
{
  const FinalSignInSignUp({super.key});

  @override
  State<FinalSignInSignUp> createState() => _FinalSignInSignUpState();
}

class _FinalSignInSignUpState extends State<FinalSignInSignUp> with TickerProviderStateMixin 
{
  late final TabController _tabController;

  @override
  void initState() 
  {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SizedBox
        (
          height: 150,
          child: Image.asset
          (
            'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png',
            width: 150,
            height: 150,
          ),
        ),
        toolbarHeight: 150,
        bottom: TabBar
        (
          indicatorColor: Theme.of(context).colorScheme.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          indicatorWeight: 3.0,
          labelStyle: TextStyle
          (
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            
          ),
          unselectedLabelStyle: TextStyle
          (
            fontWeight: FontWeight.normal
          ),
          controller: _tabController,
          tabs: const <Widget>
          [
            Tab
            (
              text: 'LOGIN',
            ),
            Tab
            (
              text: 'SIGN UP',
            ),
          ],
        ),
      ),
      body: TabBarView
      (
        controller: _tabController,
        children: <Widget>
        [
          LoginTab(),
          SignUpTab()
        ],
      ),
    );
  }
}

class LoginTab extends StatefulWidget 
{
  LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> 
{

  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  bool emailCorrect = false;
  bool emailActive = false;
  bool passwordActive = false;
  bool passwordInvisible = true;

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: EdgeInsets.all(30.0),
      child: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            TextField
            (
              controller: emailInput,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.email_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Email',
              ),
            ),
            TextField
            (
              controller: passwordInput,
              obscureText: passwordInvisible,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.key_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Password',
                suffixIcon: GestureDetector
                (
                  child: passwordInvisible ? Icon(Icons.visibility_off_rounded) : Icon(Icons.visibility_rounded),
                  onTap:() 
                  {
                    setState(() 
                    {
                      passwordInvisible = !passwordInvisible;
                    });
                  },
                )
              )
            ),
            SizedBox(height: 40.0),
            BlocConsumer<AuthenticationBloc, AuthenticationState>
            (
              builder: (context, state) 
              {
                return ElevatedButton.icon
                (
                  style: ButtonStyle
                  (
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                  ),
                  icon: const Icon
                  (
                    Icons.login_rounded,
                    color: Colors.white,
                    size: 30.0
                  ), 
                  label: const Text
                  (
                    'Login',
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: ()
                  {
                    BlocProvider.of<AuthenticationBloc>(context).add
                    (
                      AuthenticationSignInWithEmailEvent
                      (
                        emailInput.text.trim(),
                        passwordInput.text.trim(),
                      ),
                    );
                  },
                );
              }, 
              listener: (context, state) 
              {
                if (state is AuthenticationSuccessOrLoadedState) 
                {
                  Navigator.pushNamedAndRemoveUntil
                  (
                    context,
                    '/HomePage',
                    (route) => false,
                  );
                }
                else if (state is AuthenticationErrorState) 
                {
                  final signInErrorSnackBarMessage = SnackBar
                  (
                    content: Text
                    (
                      state.error,
                      style: TextStyle
                      (
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(signInErrorSnackBarMessage);
                }
              }
            ),
          ]
        ),
      ),
    );
  }
}

class SignUpTab extends StatefulWidget 
{
  SignUpTab({super.key});

  @override
  State<SignUpTab> createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> 
{
  final TextEditingController fullNameInput = TextEditingController();
  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final TextEditingController confirmpasswordInput = TextEditingController();
  final TextEditingController campusController = TextEditingController();
  String? selectedCampus = '';

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

  bool fullNameCorrect = false;
  bool emailCorrect = false;
  bool passwordMinimum8Characters = false;
  bool passwordHasOneUppercaseAlphabet = false;
  bool passwordHasOneDigit = false;
  bool passwordHasOneSpecialCharacter = false;
  bool confirmPasswordAndPasswordMatch = false;
  bool allInputFieldsCorrect = false;

  bool fullNameActive = false;
  bool emailActive = false;
  bool passwordActive = false;
  bool confirmPasswordActive = false;

  bool passwordInvisible = true;

  @override
  void initState() 
  {
    BlocProvider.of<GDSCCampusesBloc>(context).add(ReadAllGDSCCampusesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {

    List<DropdownMenuEntry<String>> campusEntries = <DropdownMenuEntry<String>>[];
    // StreamBuilder<List<GDSCCampus>>
    //       (
    //         stream: BlocProvider.of<GDSCCampusesBloc>(context).campussRepository.allGDSCCampusesFunctionInGDSCCampusesRepositoryFile(),
    //         builder: (context, snapshot)
    //         {
    //           if (snapshot.hasError) 
    //           {
    //             return Text('Error: ${snapshot.error}');
    //           } 
    //           else if (snapshot.hasData)
    //           {
                
    //             // List<GDSCCampus>? campuses = snapshot.data;
    //             // return SizedBox(
    //             //   height: 200,
    //             //   child: ListView.builder
    //             //   (
    //             //     itemCount: campuses?.length,
    //             //     itemBuilder: ((context, index) 
    //             //     {
    //             //       return Text(campuses![index].campusName);
    //             //     })
    //             //   ),
    //             // );
    //             List<GDSCCampus>? campuses = snapshot.data;
    //             campusEntries = campuses!
    //                         .map<DropdownMenuEntry<String>>(
    //                           (campus) => DropdownMenuEntry<String>(
    //                             value: campus.campusName,
    //                             label: campus.campusId
    //                           ),
    //                         )
    //                         .toList();
    //               return Text('kkk');
    //           }
    //           else
    //           {
    //             return Text('Snapshaot mein kuch tha he nahin');
    //           }
    //         }
    //       );

    // BlocBuilder<GDSCCampusesBloc, GDSCCampusesState>
    // (
    //   builder: (context, state)
    //   {
    //     if (state is GDSCCampusesLoadingState)
    //     {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     else if (state is GDSCCampusesErrorState)
    //     {
    //       return Center(child: Text(state.error));
    //     }
    //     else if (state is GDSCCampusesSuccessOrLoadedState)
    //     {
    //       return StreamBuilder<List<GDSCCampus>>
    //       (
    //         stream: state.campus,
    //         builder: (context, snapshot)
    //         {
    //           if (snapshot.hasError) 
    //           {
    //             return Text('Error: ${snapshot.error}');
    //           } 
    //           else if (snapshot.hasData)
    //           {
                
    //             // List<GDSCCampus>? campuses = snapshot.data;
    //             // return SizedBox(
    //             //   height: 200,
    //             //   child: ListView.builder
    //             //   (
    //             //     itemCount: campuses?.length,
    //             //     itemBuilder: ((context, index) 
    //             //     {
    //             //       return Text(campuses![index].campusName);
    //             //     })
    //             //   ),
    //             // );
    //             List<GDSCCampus>? campuses = snapshot.data;
    //             campusEntries = campuses!
    //                         .map<DropdownMenuEntry<String>>(
    //                           (campus) => DropdownMenuEntry<String>(
    //                             value: campus.campusName,
    //                             label: campus.campusId
    //                           ),
    //                         )
    //                         .toList();
    //               return Text('kkk');
    //           }
    //           else
    //           {
    //             return Text('Snapshaot mein kuch tha he nahin');
    //           }
    //         }
    //       );
    //     }
    //     else
    //     {
    //       return Text('Koi state he match nahin huo');
    //     }
    //   }
    // );

    return Padding
    (
      padding: EdgeInsets.all(30.0),
      child: SingleChildScrollView
      (
        child: Column
        (
          children: 
          [
            BlocBuilder<GDSCCampusesBloc, GDSCCampusesState>
            (
              builder: (context, state)
              {
                if (state is GDSCCampusesLoadingState)
                {
                  return Center(child: CircularProgressIndicator());
                }
                else if (state is GDSCCampusesErrorState)
                {
                  return Center(child: Text(state.error));
                }
                else if (state is GDSCCampusesSuccessOrLoadedState)
                {
                  return StreamBuilder<List<GDSCCampus>>
                  (
                    stream: state.campus,
                    builder: (context, snapshot)
                    {
                      if (snapshot.hasError) 
                      {
                        return Text('Error: ${snapshot.error}');
                      } 
                      else if (snapshot.hasData)
                      {
                        
List<GDSCCampus>? campuses = snapshot.data;
                        campusEntries = campuses!
                            .map<DropdownMenuEntry<String>>(
                              (campus) => DropdownMenuEntry<String>(
                                label: campus.campusName,
                                value: campus.campusId
                              ),
                            )
                            .toList();
                        return  DropdownMenu<String>
            (
              width: MediaQuery.sizeOf(context).width - 60.0, //Crazy maths here, Ash!!
              controller: campusController,
              enableFilter: true,
              leadingIcon: const Icon(Icons.school_rounded),
              label: const Text('GDSC Campus Name'),
              dropdownMenuEntries: campusEntries,
              inputDecorationTheme: const InputDecorationTheme
              (
              ),
              onSelected: (String? campus) 
              {
                setState(() 
                {
                  
                  selectedCampus = campus;
                });
              },
            );




                      }
                      else
                      {
                        return Text('Snapshaot mein kuch tha he nahin');
                      }
                    }
                  );
                }
                else
                {
                  return Text('Koi state he match nahin huo');
                }
              }
            ),
            
















            // DropdownMenu<String>
            // (
            //   width: MediaQuery.sizeOf(context).width - 60.0, //Crazy maths here, Ash!!
            //   controller: campusController,
            //   enableFilter: true,
            //   leadingIcon: const Icon(Icons.school_rounded),
            //   label: const Text('GDSC Campus Name'),
            //   dropdownMenuEntries: campusEntries,
            //   inputDecorationTheme: const InputDecorationTheme
            //   (
            //   ),
            //   onSelected: (String? campus) 
            //   {
            //     setState(() 
            //     {
                  
            //       selectedCampus = campus;
            //     });
            //   },
            // ),
            TextField
            (
              controller: fullNameInput,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.person_2_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Full Name',
              ),
              
            ),
            TextField
            (
              controller: emailInput,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.email_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Email',
              ),
            ),
            TextField
            (
              controller: passwordInput,
              obscureText: passwordInvisible,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.key_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Password',
                suffixIcon: GestureDetector
                (
                  child: passwordInvisible ? Icon(Icons.visibility_off_rounded) : Icon(Icons.visibility_rounded),
                  onTap:() 
                  {
                    setState(() 
                    {
                      passwordInvisible = !passwordInvisible;
                    });
                  },
                )
              )
            ),
            SizedBox(height: 40.0),
            BlocConsumer<AuthenticationBloc, AuthenticationState>
            (
              builder: (context, state) 
              {
                return ElevatedButton.icon
                (
                  style: ButtonStyle
                  (
                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                  ),
                  icon: const Icon
                  (
                    Icons.person_add_alt_1_rounded,
                    color: Colors.white,
                    size: 30.0
                  ), 
                  label: const Text
                  (
                    'Create Account',
                    style: TextStyle
                    (
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: ()
                  {
                    BlocProvider.of<AuthenticationBloc>(context).add
                    (
                      AuthenticationSignInWithEmailEvent
                      (
                        emailInput.text.trim(),
                        passwordInput.text.trim(),
                      ),
                    );
                  },
                );
              }, 
              listener: (context, state) 
              {
                if (state is AuthenticationSuccessOrLoadedState) 
                {
                  Navigator.pushNamedAndRemoveUntil
                  (
                    context,
                    '/HomePage',
                    (route) => false,
                  );
                }
                else if (state is AuthenticationErrorState) 
                {
                  final signUpErrorSnackBarMessage = SnackBar
                  (
                    content: Text
                    (
                      state.error,
                      style: TextStyle
                      (
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(signUpErrorSnackBarMessage);
                }
              }
            ),
          ]
        ),
      ),
    );
  }
}

