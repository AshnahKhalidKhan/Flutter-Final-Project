import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/reusable_widgets_constants/circle_progress_indicator.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/assets/Google_Pocket_App_Logo_Without_Background.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: SizedBox(width: 20.0),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
              if (state is AuthenticationErrorState) {
                final signOutErrorSnackBarMessage = SnackBar(
                  content: Text(
                    state.error,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(signOutErrorSnackBarMessage);
              } else if (state is AuthenticationSignedOutState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/LoginSignUp',
                  (route) => false,
                );
              } else {
                // return do nothing
              }
            }, builder: (context, state) {
              if (state is AuthenticationErrorState) {
                return Text(state.error);
              } else {
                return ListTile(
                  leading: Icon(Icons.logout_rounded,
                      color: Theme.of(context).colorScheme.primary, size: 30.0),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationSignOutEvent());
                  },
                );
              }
            }),
          ],
        ));
  }
}
