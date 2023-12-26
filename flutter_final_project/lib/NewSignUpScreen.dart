import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/HomeScreen.dart';
import 'package:flutter_final_project/SignUpScreen.dart';

class NewSignUpScreen extends StatelessWidget 
{
  const NewSignUpScreen({super.key});
  static String id = 'main screen';

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
                              return const AlertDialog
                              (
                                content: Text('error'),
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
            return const SignupScreen();
          }
        },
      ),
    );
  }
}