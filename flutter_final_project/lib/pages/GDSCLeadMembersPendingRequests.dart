import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/GDSCCampusesBloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/blocs/campuses_list/GDSCCampusesStates.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListBloc.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListEvents.dart';
import 'package:flutter_final_project/blocs/leads_list/GDSCLeadsMembersListStates.dart';
import 'package:flutter_final_project/models/GDSCCampusModel.dart';
import 'package:flutter_final_project/models/UserModel.dart';
import 'package:flutter_final_project/main.dart';
import 'package:flutter_final_project/blocs/authentication/AuthenticationBloc.dart';
import 'package:flutter_final_project/blocs/authentication/AuthenticationEvents.dart';
import 'package:flutter_final_project/blocs/authentication/AuthenticationStates.dart';

class GDSCLeadMembersPendingRequests extends StatefulWidget {
  const GDSCLeadMembersPendingRequests({super.key});

  @override
  State<GDSCLeadMembersPendingRequests> createState() =>
      _GDSCLeadMembersPendingRequestsState();
}

class _GDSCLeadMembersPendingRequestsState
    extends State<GDSCLeadMembersPendingRequests>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu_rounded),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Text(
          'Leads',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: TabBar(
              indicatorColor: Theme.of(context).colorScheme.secondary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
              indicatorWeight: 3.0,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Approved',
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            DrawerHeader(
              child: SizedBox(width: 20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png'),
                  fit: BoxFit.fitHeight,
                ),
                // gradient: LinearGradient(colors: [GoogleBlue, GoogleGreen, GoogleRed, GoogleYellow].toList())
              ),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return ListTile(
                  // shape: RoundedRectangleBorder
                  // (
                  //   side: BorderSide
                  //   (
                  //     color: Theme.of(context).colorScheme.primary,
                  //     width: 2.0,
                  //   ),
                  //   borderRadius: BorderRadius.circular(0.0)
                  // ),
                  // tileColor: Colors.white,
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
              },
              listener: (context, state) {
                if (state is AuthenticationInitialState) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/LoginSignUp',
                    (route) => false,
                  );
                } else if (state is AuthenticationErrorState) {
                  final signOutErrorSnackBarMessage = SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(signOutErrorSnackBarMessage);
                }
              },
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[PendingLeads(), ApprovedLeads()],
      ),
    );
  }
}

class PendingLeads extends StatefulWidget {
  const PendingLeads({
    super.key,
  });

  @override
  State<PendingLeads> createState() => _PendingLeadsState();
}

class _PendingLeadsState extends State<PendingLeads> {
  @override
  void initState() {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context)
        .add(ReadAllPendingGDSCLeadsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>(
          builder: (context, state) {
        if (state is GDSCLeadsMembersListLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GDSCLeadsMembersListErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GDSCLeadsMembersListSuccessOrLoadedState) {
          return StreamBuilder<List<AppUser>>(
              stream: state.user,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<AppUser>? users = snapshot.data;
                  return ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(20.0)),
                            tileColor: Colors.white,
                            style: ListTileStyle.list,
                            title: Text(
                              users![i].name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LeadInfoField(
                                    icon: Icons.email, text: users![i].email),
                                SizedBox(height: 10.0),
                                CampusNameField(campusId: users![i].campus),
                                // SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Spacer(),
                                    ApprovalDecisionButton(user: users![i]),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                            // trailing: ApprovalDecisionButton(user: users![i]),
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        } else {
          return Center(
              child: Text(
                  'Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
        }
      }),
    );
  }
}

class CampusNameField extends StatefulWidget {
  final campusId;

  CampusNameField({super.key, required this.campusId});

  @override
  State<CampusNameField> createState() => _CampusNameFieldState();
}

class _CampusNameFieldState extends State<CampusNameField> {
  @override
  void initState() {
    BlocProvider.of<GDSCCampusesBloc>(context)
        .add(ReadOneGDSCCampusEvent(widget.campusId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GDSCCampusesBloc, GDSCCampusesState>(
        builder: (context, state) {
      if (state is GDSCCampusesLoadingState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GDSCCampusesErrorState) {
        return Center(child: Text(state.error));
      } else if (state is OneGDSCCampusSuccessOrLoadedState) {
        return FutureBuilder(
            future: state.campus,
            builder: (context, item) {
              String campus = item.data == null
                  ? 'Campus details unavailable.'
                  : item.data!.campusName.toString();
              return LeadInfoField(icon: Icons.location_pin, text: campus);
            });
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}

class ApprovedLeads extends StatefulWidget {
  const ApprovedLeads({
    super.key,
  });

  @override
  State<ApprovedLeads> createState() => _ApprovedLeadsState();
}

class _ApprovedLeadsState extends State<ApprovedLeads> {
  @override
  void initState() {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context)
        .add(ReadAllApprovedGDSCLeadsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>(
          builder: (context, state) {
        if (state is GDSCLeadsMembersListLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GDSCLeadsMembersListErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GDSCLeadsMembersListSuccessOrLoadedState) {
          return StreamBuilder<List<AppUser>>(
              stream: state.user,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<AppUser>? users = snapshot.data;
                  return ListView.builder(
                      itemCount: users!.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(20.0)),
                            tileColor: Colors.white,
                            style: ListTileStyle.list,
                            title: Text(
                              users![i].name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LeadInfoField(
                                    icon: Icons.email, text: users![i].email),
                                SizedBox(height: 10.0),
                                CampusNameField(campusId: users![i].campus),
                                // SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    Spacer(),
                                    ApprovalDecisionButton(user: users![i]),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        } else {
          return Center(
              child: Text(
                  'Unable to load approved GDSC Leads\' list at the moment. Please try later.'));
        }
      }),
    );
  }
}

class LeadInfoField extends StatelessWidget {
  const LeadInfoField({
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
          ),
        ))
      ],
    );
  }
}

class ApprovalDecisionButton extends StatefulWidget {
  final AppUser user;

  const ApprovalDecisionButton({super.key, required this.user});

  @override
  State<ApprovalDecisionButton> createState() => _ApprovalDecisionButtonState();
}

class _ApprovalDecisionButtonState extends State<ApprovalDecisionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 60,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.primaryContainer),
          // iconColor: MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
          padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
          side: MaterialStatePropertyAll(BorderSide(
              width: 2.0,
              style: BorderStyle.solid,
              color: Theme.of(context).colorScheme.primary)),
          alignment: Alignment.center,
        ),
        // padding: EdgeInsets.all(20.0),
        // icon: Icon
        // (
        //   Icons.edit,
        //   size: 30.0
        // ),
        child: widget.user.approved!
            ? const Text('Remove')
            : const Text('Approve'),
        onPressed: () async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: widget.user.approved!
                    ? const Text('Remove Lead?')
                    : const Text('Approve Lead?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                  TextButton(
                    child: widget.user.approved!
                        ? const Text('Remove')
                        : const Text('Approve'),
                    onPressed: () {
                      if (widget.user.approved! == true) {
                        BlocProvider.of<GDSCLeadsMembersListBloc>(context)
                            .add(RemoveGDSCLeadEvent(widget.user));
                      } else {
                        BlocProvider.of<GDSCLeadsMembersListBloc>(context)
                            .add(ApproveGDSCLeadEvent(widget.user));
                      }
                      Navigator.pop(context, 'Remove/Approve');
                      final updateLeadStatusSnackBarMessage = SnackBar(
                        content: Text(
                          widget.user.approved!
                              ? 'Lead removed.'
                              : 'Lead approved.',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(updateLeadStatusSnackBarMessage);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}