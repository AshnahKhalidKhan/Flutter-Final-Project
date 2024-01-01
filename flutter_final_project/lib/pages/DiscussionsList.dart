import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/pages/RegistrationsList.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
import 'package:flutter_final_project/reusable_widgets_constants/drawer.dart';

class DiscussionsList extends StatefulWidget 
{
  const DiscussionsList({super.key});

  @override
  State<DiscussionsList> createState() => _DiscussionsListState();
}

class _DiscussionsListState extends State<DiscussionsList> 
{
  @override
  void initState() 
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: const MyAppBar(pagename: 'Discussions'),
      drawer: const MyDrawer(),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: ListView.builder
        (
          itemCount: 10,
          itemBuilder: (context, i)
          {
            return DiscussionsListNexteventChatWidgetTile
            (
              eventName: i == 0 ? 'Core Team Chat' : 'Event ' + (i + 1).toString() + ' Name',
              eventChatWidget: RegistrationsList(),
            );
          }
        ),
      )
    );
  }
}

class DiscussionsListNexteventChatWidgetTile extends StatelessWidget 
{
  const DiscussionsListNexteventChatWidgetTile
  (
    {
      super.key,
      required this.eventName,
      required this.eventChatWidget,
    }
  );

  final String eventName;
  final Widget eventChatWidget;

  @override
  Widget build(BuildContext context) 
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
        title: Text
        (
          eventName,
          style: TextStyle
          (
            fontSize: 20.0
          ),
        ),
        trailing: Icon
        (
          Icons.keyboard_arrow_right_outlined,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () 
        {
          Navigator.push
          (
            context,
            MaterialPageRoute(builder: (context) => eventChatWidget)
          );
        },
      ),
    );
  }
}