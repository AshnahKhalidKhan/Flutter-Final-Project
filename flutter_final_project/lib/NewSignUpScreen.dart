import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/HomeScreen.dart';
import 'package:flutter_final_project/SignUpScreen.dart';

class NewSignUpScreen extends StatefulWidget 
{
   NewSignUpScreen({super.key});
  static String id = 'main screen';

  @override
  State<NewSignUpScreen> createState() => _NewSignUpScreenState();
}

class _NewSignUpScreenState extends State<NewSignUpScreen> {
  // Text Controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() 
  {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: StreamBuilder<User?>
      (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) 
        {
          if (snapshot.hasData) 
          {
            return Scaffold
            (
              body: Center
              (
                child: Column
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                  [
                    const Text
                    (
                      'Hello User',
                      style: TextStyle
                      (
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AuthenticationBloc, AuthenticationState>
                    (
                      listener: (context, state) 
                      {
                        if (state is AuthenticationLoadingState) 
                        {
                          const CircularProgressIndicator();
                        } 
                        else if (state is AuthenticationErrorState)
                        {
                          showDialog
                          (context: context, builder: (context)
                            {
                              return AlertDialog
                              (
                                content: Text(state.error.toString()),
                              );
                            }
                          );
                        }
                      },
                      builder: (context, state) 
                      {
                        return ElevatedButton
                        (
                          onPressed: () 
                          {
                            BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationSignOutEvent());
                          },
                          child: const Text
                          (
                            'logOut'
                          )
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          else 
          {
            return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login to Your Account',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Email address'),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 10),
            const Text('Password'),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
              ),
              obscureText: false,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccessOrLoadedState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.id,
                    (route) => false,
                  );
                } else if (state is AuthenticationErrorState) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('Sign Up wala error hai'),
                        );
                      });
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationSignUpWithEmailEvent(
                          'Ashnah',
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          'admin',
                          'Institute of Business Administration'
                        ),
                      );
                    },
                    child:  Text(
                      state is AuthenticationLoadingState
                            ? '.......'
                            : 'Signup',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
          }
        },
      ),
    );
  }
}