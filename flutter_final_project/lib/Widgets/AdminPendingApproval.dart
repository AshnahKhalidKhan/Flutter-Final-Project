import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';

class AdminPendingRequest extends StatefulWidget 
{
  const AdminPendingRequest({super.key});

  @override
  State<AdminPendingRequest> createState() => _AdminPendingRequestState();
}

class _AdminPendingRequestState extends State<AdminPendingRequest> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text
        (
          'Pending Approval', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding
      (
        padding: EdgeInsets.all(20.0),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Spacer(),
            Image.asset
            (
              'lib/Assets/Pending_Approval.png',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 30.0),
            Text
            (
              'Your Admin request needs to be approved by another Admin before you can access your Admin privelleges. Please return once your request has been approved.',
              style: TextStyle
              (
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
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
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 30.0
                  ), 
                  label: const Text
                  (
                    'Sign Out',
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
                      AuthenticationSignOutEvent()
                    );
                  },
                );
              },
              listener: (context, state) 
              {
                if (state is AuthenticationInitialState) 
                {
                  Navigator.pushNamedAndRemoveUntil
                  (
                    context,
                    '/LoginSignUp',
                    (route) => false,
                  );
                }
                else if (state is AuthenticationErrorState) 
                {
                  final signOutErrorSnackBarMessage = SnackBar
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
                  ScaffoldMessenger.of(context).showSnackBar(signOutErrorSnackBarMessage);
                }
              },
            )
          ],
        ),
      )
    );
  }
}