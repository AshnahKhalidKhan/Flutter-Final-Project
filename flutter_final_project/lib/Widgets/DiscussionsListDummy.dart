import 'package:flutter/material.dart';
import 'package:flutter_final_project/Widgets/RegistrationsList.dart';

class DiscussionsListDummy extends StatefulWidget 
{
  const DiscussionsListDummy({super.key});

  @override
  State<DiscussionsListDummy> createState() => _DiscussionsListDummyState();
}

class _DiscussionsListDummyState extends State<DiscussionsListDummy> 
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
        leading: Icon
        (
          Icons.message_rounded,
          color: Colors.white,
          size: 30.0
        ),
        title: const Text
        (
          'Discussions', 
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
        child: ListView.builder
        (
          itemCount: 10,
          itemBuilder: (context, i)
          {
            return DiscussionsListDummyNexteventChatWidgetTile
            (
              eventName: 'Event ' + (i + 1).toString() + ' Name',
              eventChatWidget: RegistrationsList(),
            );
          }
        ),
      )
    );
  }
}

class DiscussionsListDummyNexteventChatWidgetTile extends StatelessWidget 
{
  const DiscussionsListDummyNexteventChatWidgetTile
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