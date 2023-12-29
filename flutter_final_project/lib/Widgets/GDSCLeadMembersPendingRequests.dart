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
              text: 'Pending',
            ),
            Tab
            (
              text: 'Approved',
            ),
          ],
        ),
      ),
      body: TabBarView
      (
        controller: _tabController,
        children: <Widget>
        [
          Text('Babe'),
          Text('Approved babe'),
        ],
      ),
      // body: Padding
      // (
      //   padding: EdgeInsets.all(10.0),
      //   child: Column
      //   (
      //     children: 
      //     [
      //       // BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
      //       // (
      //       //   builder: (context, state)
      //       //   {
      //       //     if (state is GDSCLeadsMembersListLoadingState)
      //       //     {
      //       //       return Center(child: CircularProgressIndicator());
      //       //     }
      //       //     else if (state is GDSCLeadsMembersListErrorState)
      //       //     {
      //       //       return Center(child: Text(state.error));
      //       //     }
      //       //     else if (state is GDSCLeadsMembersListSuccessOrLoadedState)
      //       //     {
      //       //       return StreamBuilder<List<AppUser>>
      //       //       (
      //       //         stream: state.user,
      //       //         builder: (context, snapshot)
      //       //         {
      //       //           if (snapshot.hasError) 
      //       //           {
      //       //             return Text('Error: ${snapshot.error}');
      //       //           } 
      //       //           else if (snapshot.hasData)
      //       //           {
      //       //             List<AppUser>? campuses = snapshot.data;
      //       //             return SizedBox(
      //       //               height: 200,
      //       //               child: ListView.builder
      //       //               (
      //       //                 itemCount: campuses!.length,
      //       //                 itemBuilder: (context, i)
      //       //                 {
      //       //                   return Text(campuses![i].name);
      //       //                 }
      //       //               ),
      //       //             );
      //       //           }
      //       //           else
      //       //           {
      //       //             return Center(child: Text(state.toString()));
      //       //           }
      //       //         }
      //       //       );
      //       //     }
      //       //     // else
      //       //     // {
      //       //     //   return Center(child: Text('Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
      //       //     // }
      //       //     if (state is GDSCLeadsMembersListSuccessOrLoadedState)
      //       //     {
      //       //       return Text('data');
      //       //     }
      //       //     else
      //       //     {
      //       //       return Center(child: Text('Unable to load pending GDSC Leads\' list at the moment. Please try later.'));
      //       //     }
      //       //   }
      //       // ),
      //       // BlocBuilder<GDSCLeadsMembersListBloc, GDSCLeadsMembersListState>
      //       // (
      //       //   builder: (context, state)
      //       //   {
      //       //     if (state is GDSCLeadsMembersListLoadingState)
      //       //     {
      //       //       return Center(child: CircularProgressIndicator());
      //       //     }
      //       //     else if (state is GDSCLeadsMembersListErrorState)
      //       //     {
      //       //       return Center(child: Text(state.error));
      //       //     }
      //       //     else if (state is GDSCLeadsMembersListSuccessOrLoadedState)
      //       //     {
      //       //       return StreamBuilder<List<AppUser>>
      //       //       (
      //       //         stream: state.user,
      //       //         builder: (context, snapshot)
      //       //         {
      //       //           if (snapshot.hasError) 
      //       //           {
      //       //             return Text('Error: ${snapshot.error}');
      //       //           } 
      //       //           else if (snapshot.hasData)
      //       //           {
      //       //             List<AppUser>? campuses = snapshot.data;
      //       //             return SizedBox(
      //       //               height: 200,
      //       //               child: ListView.builder
      //       //               (
      //       //                 itemCount: campuses!.length,
      //       //                 itemBuilder: (context, i)
      //       //                 {
      //       //                   return Text(campuses![i].name);
      //       //                 }
      //       //               ),
      //       //             );
      //       //           }
      //       //           else
      //       //           {
      //       //             // return Center(child: CircularProgressIndicator());
      //       //             return Center(child: Text(state.toString()));
      //       //           }
      //       //         }
      //       //       );
      //       //     }
      //       //     else
      //       //     {
      //       //       return Center(child: Text('Unable to load approved GDSC Leadss\' list at the moment. Please try later.'));
      //       //     }
      //       //   }
      //       // ),
      //     ],
      //   ),
      // )
    );
  }
}