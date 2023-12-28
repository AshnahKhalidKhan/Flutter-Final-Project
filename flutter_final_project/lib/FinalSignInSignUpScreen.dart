import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/HomeScreen.dart';

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
  final Text error = Text('');

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
                  'LoginTab',
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
                showDialog
                (
                context: context,
                builder: (context) 
                {
                  return AlertDialog
                  (
                    content: Text(state.error),
                  );
                  }
                );
              }
            }
          ),
        ]
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

  final TextEditingController emailInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();
  final Text error = Text('');

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
                  'SignUpTab',
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
                showDialog
                (
                context: context,
                builder: (context) 
                {
                  return AlertDialog
                  (
                    content: Text(state.error),
                  );
                  }
                );
              }
            }
          ),
        ]
      ),
    );
  }
}

