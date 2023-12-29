import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesStates.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListStates.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';
import 'package:flutter_final_project/Models/UserModel.dart';
import 'package:flutter_final_project/main.dart';

class GDSCLeadMembersPendingRequests extends StatefulWidget 
{
  const GDSCLeadMembersPendingRequests({super.key});

  @override
  State<GDSCLeadMembersPendingRequests> createState() => _GDSCLeadMembersPendingRequestsState();
}

class _GDSCLeadMembersPendingRequestsState extends State<GDSCLeadMembersPendingRequests> with TickerProviderStateMixin 
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
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text
        (
          'Leads', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        bottom: PreferredSize
        (
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container
          (
            color: Colors.white,
            child: TabBar
            (
              indicatorColor: Theme.of(context).colorScheme.secondary,
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
                  text: 'Pending',
                ),
                Tab
                (
                  text: 'Approved',
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView
      (
        controller: _tabController,
        children: <Widget>
        [
          PendingLeads(),
          ApprovedLeads()
        ],
      ),
    );
  }
}

class PendingLeads extends StatefulWidget 
{
  const PendingLeads({
    super.key,
  });

  @override
  State<PendingLeads> createState() => _PendingLeadsState();
}

class _PendingLeadsState extends State<PendingLeads> 
{
  @override
  void initState() 
  {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context).add(ReadAllPendingGDSCLeadsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: EdgeInsets.all(10.0),
      child: BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
      (
        builder: (context, state)
        {
          if (state is GDSCLeadsMembersListLoadingState)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is GDSCLeadsMembersListErrorState)
          {
            return Center(child: Text(state.error));
          }
          else if (state is GDSCLeadsMembersListSuccessOrLoadedState)
          {
            return StreamBuilder<List<AppUser>>
            (
              stream: state.user,
              builder: (context, snapshot)
              {
                if (snapshot.hasError) 
                {
                  return Text('Error: ${snapshot.error}');
                } 
                else if (snapshot.hasData)
                {
                  List<AppUser>? users = snapshot.data;
                  return ListView.builder
                  (
                    itemCount: users!.length,
                    itemBuilder: (context, i)
                    {
                      return Padding
                      (
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ListTile
                        (
                          shape: RoundedRectangleBorder
                          (
                            side: BorderSide
                            (
                              color: Theme.of(context).colorScheme.primary,
                              width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          tileColor: Colors.white,
                          style: ListTileStyle.list,
                          title: Text
                          (
                            users![i].name,
                            style: TextStyle
                            (
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Column
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: 
                            [
                              LeadInfoField(icon: Icons.email, text: users![i].email),
                              SizedBox(height: 10.0),
                              CampusNameField(campusId: users![i].campus),
                              // SizedBox(height: 10.0),
                              // LeadInfoField(icon: Icons.star_rounded, text: campus.lead.isEmpty ? 'No Lead assigned' : campus.lead),
                            ],
                          ),
                          trailing: Icon
                          (
                            Icons.expand_more,
                            size: 40.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onTap: () 
                          {
                            // GDSCCampusTileBottomSheet(context, campus);
                          },
                        ),
                      );
                    }
                  );
                }
                else
                {
                  return Center(child: CircularProgressIndicator());
                }
              }
            );
          }
          else
          {
            return Center(child: Text('Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
          }
        }
      ),
    );
  }
}

class CampusNameField extends StatefulWidget 
{
  final campusId;

  CampusNameField({
    super.key,
    required this.campusId
  });

  @override
  State<CampusNameField> createState() => _CampusNameFieldState();
}

class _CampusNameFieldState extends State<CampusNameField> 
{
  @override
  void initState() 
  {
    BlocProvider.of<GDSCCampusesBloc>(context).add(ReadOneGDSCCampusEvent(widget.campusId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return BlocBuilder<GDSCCampusesBloc, GDSCCampusesState>
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
        else if (state is OneGDSCCampusSuccessOrLoadedState)
        {
          return FutureBuilder
          (
            future: state.campus, 
            builder: (context, item)
            {
              String campus = item.data == null ? 'Campus details unavailable.' : item.data!.campusName.toString();
              return LeadInfoField(icon: Icons.location_pin, text: campus);
            }
          );
        }
        else
        {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}


class ApprovedLeads extends StatefulWidget 
{
  const ApprovedLeads({
    super.key,
  });

  @override
  State<ApprovedLeads> createState() => _ApprovedLeadsState();
}

class _ApprovedLeadsState extends State<ApprovedLeads> 
{
  @override
  void initState() 
  {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context).add(ReadAllApprovedGDSCLeadsListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: EdgeInsets.all(10.0),
      child: BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
      (
        builder: (context, state)
        {
          if (state is GDSCLeadsMembersListLoadingState)
          {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is GDSCLeadsMembersListErrorState)
          {
            return Center(child: Text(state.error));
          }
          else if (state is GDSCLeadsMembersListSuccessOrLoadedState)
          {
            return StreamBuilder<List<AppUser>>
            (
              stream: state.user,
              builder: (context, snapshot)
              {
                if (snapshot.hasError) 
                {
                  return Text('Error: ${snapshot.error}');
                } 
                else if (snapshot.hasData)
                {
                  List<AppUser>? users = snapshot.data;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder
                    (
                      itemCount: users!.length,
                      itemBuilder: (context, i)
                      {
                        return Text(users![i].name);
                      }
                    ),
                  );
                }
                else
                {
                  return Center(child: CircularProgressIndicator());
                }
              }
            );
          }
          else
          {
            return Center(child: Text('Unable to load approved GDSC Leads\' list at the moment. Please try later.'));
          }
        }
      ),
    );
  }
}

class LeadInfoField extends StatelessWidget 
{  
  const LeadInfoField
  (
    {
      super.key,
      required this.icon,
      required this.text,
    }
  );

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) 
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.start,
      children: 
      [
        Icon
        (
          icon,
          size: 20.0,
          color: Theme.of(context).colorScheme.primary
        ),
        SizedBox(width: 10.0),
        Expanded
        (
          child: Text
          (
            text,
            style: TextStyle
            (
              fontSize: 15.0,
            ),
          )
        )
      ],
    );
  }
}