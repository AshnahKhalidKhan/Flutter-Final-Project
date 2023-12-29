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
                  if (state.user.role.startsWith('Admin'))
                  {
                    Navigator.pushNamedAndRemoveUntil
                    (
                      context,
                      '/AdminHomePage',
                      (route) => false,
                    );
                  }
                  else
                  {
                    Navigator.pushNamedAndRemoveUntil
                    (
                      context,
                      '/HomePage',
                      (route) => false,
                    );
                  }
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
  String? selectedRole = '';

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

    return Padding
    (
      padding: EdgeInsets.all(20.0),
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
                        campusEntries = campuses!.map<DropdownMenuEntry<String>>
                        (
                          (campus) => DropdownMenuEntry<String>
                          (
                            label: campus.campusName,
                            value: campus.campusId,
                            style: ButtonStyle
                            (
                              alignment: Alignment.center,
                              side: MaterialStatePropertyAll(BorderSide(width: 0.2, color: Theme.of(context).colorScheme.primary)),
                            )
                          ),
                        ).toList();
                        return  DropdownMenu<String>
                        (
                          menuHeight: 400,
                          width: MediaQuery.sizeOf(context).width - 60.0, //Crazy maths here, Ash!!
                          controller: campusController,
                          enableFilter: false,
                          leadingIcon: Icon(Icons.school_rounded, color: Theme.of(context).colorScheme.primary),
                          label: Text
                          (
                            'GDSC Campus Name',
                            style: TextStyle
                            (
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          menuStyle: MenuStyle
                          (
                            side: MaterialStatePropertyAll(BorderSide(width: 1.0, color: Theme.of(context).colorScheme.primary))
                          ),
                          dropdownMenuEntries: campusEntries,
                          onSelected: (String? campus) 
                          {
                            setState(() 
                            {
                              fullNameActive = false;
                              emailActive = false;
                              passwordActive = false;
                              confirmPasswordActive = false;
                              selectedCampus = campus;
                            });
                            if (fullNameCorrect && emailCorrect && passwordMinimum8Characters && passwordHasOneUppercaseAlphabet && passwordHasOneDigit && passwordHasOneSpecialCharacter && confirmPasswordAndPasswordMatch && selectedCampus != null)
                            {
                              setState(() 
                              {
                                allInputFieldsCorrect = true;
                              });
                            }
                            else
                            {
                              setState(() 
                              {
                                allInputFieldsCorrect = false;
                              });
                            }
                          },
                        );
                      }
                      else
                      {
                        return Text('Connection error. Please sign up later.');
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
            TextField
            (
              onTap: () 
              {
                setState(() 
                {
                  fullNameActive = true;
                  emailActive = false;
                  passwordActive = false;
                  confirmPasswordActive = false;
                });
              },
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
                helperText: fullNameActive ? (fullNameCorrect ? null : 'Each word must be capitalized.') : null,
                suffixIcon: fullNameActive ? (fullNameCorrect ? GreenCheckIcon : RedCrossIcon) : null,
              ),
              onChanged: (value)
              {
                if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(fullNameInput.text) == true && (RegExp(r'\b[A-Z]').allMatches(fullNameInput.text).length == fullNameInput.text.split(' ').length) == true)
                {
                  setState(() 
                  {
                    fullNameCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    fullNameCorrect = false;
                  });
                }
                if (fullNameCorrect && emailCorrect && passwordMinimum8Characters && passwordHasOneUppercaseAlphabet && passwordHasOneDigit && passwordHasOneSpecialCharacter && confirmPasswordAndPasswordMatch && selectedCampus != null)
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = false;
                  });
                }
              },
            ),
            TextField
            (
              onTap: () 
              {
                setState(() 
                {
                  fullNameActive = false;
                  emailActive = true;
                  passwordActive = false;
                  confirmPasswordActive = false;
                });
              },
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
                helperText: emailActive ? (emailCorrect ? null : 'Email must be valid.') : null,
                suffixIcon: emailActive ? (emailCorrect ? GreenCheckIcon : RedCrossIcon) : null,
              ),
              onChanged: (value)
              {
                if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false, multiLine: false).hasMatch(emailInput.text) == true)
                {
                  setState(() 
                  {
                    emailCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    emailCorrect = false;
                  });
                }
                if (fullNameCorrect && emailCorrect && passwordMinimum8Characters && passwordHasOneUppercaseAlphabet && passwordHasOneDigit && passwordHasOneSpecialCharacter && confirmPasswordAndPasswordMatch && selectedCampus != null)
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = false;
                  });
                }
              },
            ),
            TextField
            (
              onTap: () 
              {
                setState(() 
                {
                  fullNameActive = false;
                  emailActive = false;
                  passwordActive = true;
                  confirmPasswordActive = false;
                });
              },
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
                ),
                error: Column
                (
                  children: passwordActive ? <Widget>
                  [
                    Row
                    (
                      children:
                      [
                        passwordMinimum8Characters ? GreenCheckIcon : RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Minimum 8 characters'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        passwordHasOneUppercaseAlphabet ? GreenCheckIcon : RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one uppercase alphabet (A-Z)'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        
                        passwordHasOneDigit ? GreenCheckIcon : RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one digit (0-9)'),
                      ],
                    ),
                    Row
                    (
                      children: 
                      [
                        passwordHasOneSpecialCharacter ? GreenCheckIcon : RedCrossIcon,
                        SizedBox(width: 5.0),
                        Text('Has one special character (!, @, #...)'),
                      ],
                    ),
                  ].toList() : <Widget>[],
                ),
              ),
              onChanged: (value)
              {
                if (RegExp(r'^.{8,}$').hasMatch(passwordInput.text) == true)
                {
                  setState(() 
                  {
                    passwordMinimum8Characters = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    passwordMinimum8Characters = false;
                  });
                }
                if (RegExp(r'[A-Z]').hasMatch(passwordInput.text) == true)
                {
                  setState(() 
                  {
                    passwordHasOneUppercaseAlphabet = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    passwordHasOneUppercaseAlphabet = false;
                  });
                }
                if (RegExp(r'[0-9]').hasMatch(passwordInput.text) == true)
                {
                  setState(() 
                  {
                    passwordHasOneDigit = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    passwordHasOneDigit = false;
                  });
                }
                if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(passwordInput.text) == true)
                {
                  setState(() 
                  {
                    passwordHasOneSpecialCharacter = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    passwordHasOneSpecialCharacter = false;
                  });
                }
                if (fullNameCorrect && emailCorrect && passwordMinimum8Characters && passwordHasOneUppercaseAlphabet && passwordHasOneDigit && passwordHasOneSpecialCharacter && confirmPasswordAndPasswordMatch && selectedCampus != null)
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = false;
                  });
                }
              },
            ),
            TextField
            (
              onTap: () 
              {
                setState(() 
                {
                  fullNameActive = false;
                  emailActive = false;
                  passwordActive = false;
                  confirmPasswordActive = true;
                });
              },
              controller: confirmpasswordInput,
              obscureText: true,
              decoration: InputDecoration
              (
                labelStyle: TextStyle
                (
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                prefixIcon: Icon(Icons.key_rounded, color: Theme.of(context).colorScheme.primary,),
                labelText: 'Confirm Password',
                helperText: confirmPasswordActive ? (confirmPasswordAndPasswordMatch ? null : 'Passwords do not match.') : null,
                suffixIcon: confirmPasswordActive ? (confirmPasswordAndPasswordMatch ? GreenCheckIcon : RedCrossIcon) : null,
              ),
              onChanged: (value) 
              {
                if (confirmpasswordInput.text == passwordInput.text)
                {
                  setState(() 
                  {
                    confirmPasswordAndPasswordMatch = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    confirmPasswordAndPasswordMatch = false;
                  });
                }
                if (fullNameCorrect && emailCorrect && passwordMinimum8Characters && passwordHasOneUppercaseAlphabet && passwordHasOneDigit && passwordHasOneSpecialCharacter && confirmPasswordAndPasswordMatch && selectedCampus != null)
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = true;
                  });
                }
                else
                {
                  setState(() 
                  {
                    allInputFieldsCorrect = false;
                  });
                }
              },
            ),
            SizedBox(height: 15.0),
            Text
            (
              'Select Role',
              style: TextStyle
              (
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding
            (
              padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
              child: SegmentedButton
              (
                segments:
                [
                  ButtonSegment(value: 'Member', label: Text('Member')),
                  ButtonSegment(value: 'Lead', label: Text('Lead')),
                ], 
                selected: {selectedRole},
                onSelectionChanged: (value) 
                {
                  setState(() 
                  {
                    fullNameActive = false;
                    emailActive = false;
                    passwordActive = false;
                    confirmPasswordActive = false;
                    selectedRole = value.first;
                  });
                },
                style: ButtonStyle
                (
                  textStyle: MaterialStatePropertyAll
                  (
                    TextStyle
                    (
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10.0),
            BlocConsumer<AuthenticationBloc, AuthenticationState>
            (
              builder: (context, state) 
              {
                return ElevatedButton.icon
                (
                  style: ButtonStyle
                  (
                    backgroundColor: allInputFieldsCorrect ? MaterialStatePropertyAll(Theme.of(context).colorScheme.primary) : null,
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
                  onPressed: allInputFieldsCorrect! ? null : ()
                  {
                    BlocProvider.of<AuthenticationBloc>(context).add
                    (
                      AuthenticationSignUpWithEmailEvent
                      (
                        fullNameInput.text.trim(),
                        emailInput.text.trim(),
                        passwordInput.text.trim(),
                        selectedRole!.trim(),
                        selectedCampus!.trim()
                      ),
                    );
                  },
                );
              }, 
              listener: (context, state) 
              {
                if (state is AuthenticationSuccessOrLoadedState) 
                {
                  if (selectedRole!.startsWith('Member'))
                  {
                    Navigator.pushNamedAndRemoveUntil
                    (
                      context,
                      '/GDSCMembersPendingRequest',
                      (route) => false,
                    );
                  }
                  else if (selectedRole!.startsWith('Lead'))
                  {
                    Navigator.pushNamedAndRemoveUntil
                    (
                      context,
                      '/GDSCLeadPendingRequest',
                      (route) => false,
                    );
                  }
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

