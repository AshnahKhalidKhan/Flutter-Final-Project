import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget 
{
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> 
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
        leading: BackButton
        (
          color: Colors.white,
        ),
        title: const Text
        (
          'Event Details', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Column
      (
        children: 
        [
          ListTile
          (
            title: Text('Discussion'),
            trailing: IconButton
            (
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {},
            )
          ),
          ListTile
          (
            title: Text('Tasks'),
            trailing: IconButton
            (
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {},
            )
          ),
          ListTile
          (
            title: Text('Drafts'),
            trailing: IconButton
            (
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {},
            )
          ),
          ListTile
          (
            title: Text('Registration List'),
            trailing: IconButton
            (
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {},
            )
          ),
          ListTile
          (
            title: Text('Attendees List'),
            trailing: IconButton
            (
              icon: Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {},
            )
          )
        ],
      )
    );
  }
}