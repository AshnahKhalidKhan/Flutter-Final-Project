import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListBloc.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListEvents.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListStates.dart';
import 'package:flutter_final_project/models/user_model.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
import 'package:flutter_final_project/reusable_widgets_constants/circle_progress_indicator.dart';
import 'package:flutter_final_project/reusable_widgets_constants/drawer.dart';
import 'package:flutter_final_project/reusable_widgets_constants/list_tile_icon_text_info.dart';

class AdminsList extends StatefulWidget {
  const AdminsList({super.key});

  @override
  State<AdminsList> createState() => _AdminsListState();
}

class _AdminsListState extends State<AdminsList> {
  @override
  void initState() {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context)
        .add(ReadAllAdminsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(pagename: 'Admins'),
      drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {},
            shape: CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: AdminAddButton()),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child:
              BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>(
                  builder: (context, state) {
            if (state is GDSCLeadsMembersListLoadingState) {
              return const MyCircularProgressIndicator();
            } else if (state is GDSCLeadsMembersListErrorState) {
              return Center(child: Text(state.error));
            } else if (state is GDSCLeadsMembersListSuccessOrLoadedState) {
              return StreamBuilder<List<AppUser>>(
                  stream: state.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<AppUser>? admines = snapshot.data;
                      return ListView.builder(
                          itemCount: admines!.length,
                          itemBuilder: (context, i) {
                            return AdminTile(context, admines![i]);
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return Center(
                  child: Text(
                      'Unable to load admines list at the moment. Please try later.'));
            }
          }),
        ));
  }
}

class AdminAddButton extends StatelessWidget {
  const AdminAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.add, size: 40.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final TextEditingController adminName = TextEditingController();
            final TextEditingController adminEmail = TextEditingController();
            final TextEditingController adminLead = TextEditingController();
            final TextEditingController adminPassword = TextEditingController();

            return AlertDialog(
              title: const Text('Add Admin'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: adminName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value) {},
                  ),
                  TextField(
                    controller: adminEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: adminPassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        labelText: 'Password',
                        error: Expanded(
                          child: Text(
                              'Password must be at least 6 characters long.'),
                        )),
                    onChanged: (value) {
                      //
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    if (adminPassword.text.length >= 6) {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationSignUpWithEmailEvent(
                              adminName.text,
                              adminEmail.text,
                              adminPassword.text,
                              'Admin',
                              ''));
                      Navigator.pop(context, 'Save');
                      final addAdminSnackBarMessage = SnackBar(
                        content: Text(
                          'Admin added.',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(addAdminSnackBarMessage);
                    } else {
                      // Navigator.pop(context, 'Save');
                      final addAdminSnackBarMessage = SnackBar(
                        content: Text(
                          'Admin not added. Make sure all fields are filled and valid.',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(addAdminSnackBarMessage);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Padding AdminTile(BuildContext context, AppUser admin) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          borderRadius: BorderRadius.circular(20.0)),
      tileColor: Colors.white,
      style: ListTileStyle.list,
      title: Text(
        admin.name,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTileIconTextInfo(icon: Icons.person_2_rounded, info: admin.name),
          SizedBox(height: 10.0),
          ListTileIconTextInfo(icon: Icons.email, info: admin.email),
          SizedBox(height: 10.0),
          ListTileIconTextInfo(
              icon: Icons.verified_user_rounded,
              info: admin.approved! ? 'Approved' : 'Not approved'),
          SizedBox(height: 20.0),
          // AdminInfoField(icon: Icons.star_rounded, text: admin.lead.isEmpty ? 'No Lead assigned' : admin.lead),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AdminDeleteButton(user: admin),
              AdminEditButton(user: admin)
            ],
          ),
        ],
      ),
      // trailing: Icon
      // (
      //   Icons.expand_more,
      //   size: 40.0,
      //   color: Theme.of(context).colorScheme.primary,
      // ),
    ),
  );
}

class AdminInfoField extends StatelessWidget {
  const AdminInfoField({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 20.0, color: Theme.of(context).colorScheme.primary),
        SizedBox(width: 10.0),
        Expanded(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 15.0,
            // color: Colors.black
          ),
        ))
      ],
    );
  }
}

class AdminDeleteButton extends StatelessWidget {
  AdminDeleteButton({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: const ButtonStyle(
        iconColor: MaterialStatePropertyAll(Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.delete, size: 30.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete admin?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    BlocProvider.of<GDSCLeadsMembersListBloc>(context)
                        .add(DeleteGDSCLeadsMembersListEvent(
                      user.id,
                    ));
                    Navigator.pop(context, 'OK');
                    final deleteAdminSnackBarMessage = SnackBar(
                      content: Text(
                        'Admin deleted.',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(deleteAdminSnackBarMessage);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class AdminEditButton extends StatefulWidget {
  final AppUser user;

  const AdminEditButton({super.key, required this.user});

  @override
  State<AdminEditButton> createState() => _AdminEditButtonState();
}

class _AdminEditButtonState extends State<AdminEditButton> {
  @override
  Widget build(BuildContext context) {
    AppUser updatedAdmin = AppUser(
        id: widget.user.id,
        name: widget.user.name,
        email: widget.user.email,
        role: widget.user.role,
        campus: widget.user.campus,
        approved: widget.user.approved);
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.edit, size: 30.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final TextEditingController name =
                TextEditingController(text: widget.user.name);
            final TextEditingController email =
                TextEditingController(text: widget.user.email);
            final TextEditingController approved =
                TextEditingController(text: widget.user.approved.toString());

            return AlertDialog(
              title: const Text('Edit Admin'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      updatedAdmin = updatedAdmin.copyWith(name: name.text);
                    },
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      updatedAdmin = updatedAdmin.copyWith(email: email.text);
                    },
                  ),
                  TextField(
                    controller: approved,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.verified_user_rounded),
                      labelText: 'Approved',
                    ),
                    onChanged: (value) {
                      setState(() {
                        updatedAdmin = updatedAdmin.copyWith(
                            approved:
                                approved.text.toLowerCase().startsWith('true')
                                    ? true
                                    : false);
                        // print(updatedAdmin.toString());
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    BlocProvider.of<GDSCLeadsMembersListBloc>(context)
                        .add(UpdateGDSCLeadsMembersListEvent(updatedAdmin));
                    Navigator.pop(context, 'Save');
                    final updateAdminSnackBarMessage = SnackBar(
                      content: Text(
                        'Admin information updated.',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(updateAdminSnackBarMessage);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
