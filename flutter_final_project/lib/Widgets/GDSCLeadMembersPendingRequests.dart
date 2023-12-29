import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListStates.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

class GDSCLeadMembersPendingRequests extends StatefulWidget 
{
  const GDSCLeadMembersPendingRequests({super.key});

  @override
  State<GDSCLeadMembersPendingRequests> createState() => _GDSCLeadMembersPendingRequestsState();
}

class _GDSCLeadMembersPendingRequestsState extends State<GDSCLeadMembersPendingRequests> 
{


  @override
  void initState() 
  {
    BlocProvider.of<GDSCLeadsMembersListBloc>(context).add(ReadAllApprovedGDSCLeadsListEvent());
    BlocProvider.of<GDSCLeadsMembersListBloc>(context).add(ReadAllPendingGDSCLeadsListEvent());
    super.initState();
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
        title: const Text
        (
          'Campuses', 
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
        padding: EdgeInsets.all(10.0),
        child: Column
        (
          children: 
          [
            BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
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
                        List<AppUser>? campuses = snapshot.data;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder
                          (
                            itemCount: campuses!.length,
                            itemBuilder: (context, i)
                            {
                              return Text(campuses![i].name);
                            }
                          ),
                        );
                      }
                      else
                      {
                        return Center(child: Text(state.toString()));
                      }
                    }
                  );
                }
                // else
                // {
                //   return Center(child: Text('Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
                // }
                if (state is GDSCLeadsMembersListSuccessOrLoadedState)
                {
                  return Text('data');
                }
                else
                {
                  return Center(child: Text('Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
                }
              }
            ),
            BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
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
                        List<AppUser>? campuses = snapshot.data;
                        return SizedBox(
                          height: 200,
                          child: ListView.builder
                          (
                            itemCount: campuses!.length,
                            itemBuilder: (context, i)
                            {
                              return Text(campuses![i].name);
                            }
                          ),
                        );
                      }
                      else
                      {
                        // return Center(child: CircularProgressIndicator());
                        return Center(child: Text(state.toString()));
                      }
                    }
                  );
                }
                else
                {
                  return Center(child: Text('Unable to load approved GDSC Leadss\' list at the moment. Please try later.'));
                }
              }
            ),
          ],
        ),
      )
    );
  }
}