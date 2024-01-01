import 'package:flutter/material.dart';
import 'package:flutter_final_project/Models/EventModel.dart';
import 'package:flutter_final_project/Widgets/RegistrationsList.dart';

class EventDetails extends StatefulWidget 
{
  EventDetails({super.key});

  // final Event event;

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
          onPressed: ()
          {
            // Navigator.popUntil
            // (
            //   context,
            //   // '/EventsList', 
            //   // (route) => false,
            //   // arguments: event
            //   ModalRoute.withName('/Homepage')
            // );
            // Navigator.of(context).pop();
            Navigator.popUntil
            (
              context,
              ModalRoute.withName('/HomePage'),
            );
          },
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
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView
        (
          child: Column
          (
            children: 
            [
              EventDetailsInfoTile(sectionName: 'Web Development Bootcamp Session 2',),
              
              EventDetailsNextSectionTile
              (
                icon: Icons.message,
                sectionName: 'Discussion',
                section: RegistrationsList(),
              ),
              EventDetailsNextSectionTile
              (
                icon: Icons.note_alt_rounded,
                sectionName: 'Tasks',
                section: RegistrationsList(),
              ),
              EventDetailsNextSectionTile
              (
                icon: Icons.edit_note_rounded,
                sectionName: 'Drafts',
                section: RegistrationsList(),
              ),
              EventDetailsNextSectionTile
              (
                icon: Icons.person_add_alt_rounded,
                sectionName: 'Registrations List',
                section: RegistrationsList(),
              ),
              EventDetailsNextSectionTile
              (
                icon: Icons.people,
                sectionName: 'Attendees List',
                section: RegistrationsList(),
              ),
              EventDetailsNextSectionTile
              (
                icon: Icons.folder_special_rounded,
                sectionName: 'Assets',
                section: RegistrationsList(),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class EventDetailsNextSectionTile extends StatelessWidget 
{
  const EventDetailsNextSectionTile
  (
    {
      super.key,
      required this.icon,
      required this.sectionName,
      required this.section,
    }
  );

  final IconData icon;
  final String sectionName;
  final Widget section;

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
        leading: Icon
        (
          icon,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text
        (
          sectionName,
          style: TextStyle
          (
            fontSize: 20.0
          ),
        ),
        trailing: IconButton
        (
          icon: Icon
          (
            Icons.keyboard_arrow_right_outlined,
            size: 40.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () 
          {
            Navigator.push
            (
              context,
              MaterialPageRoute(builder: (context) => section)
            );
          },
        )
      ),
    );
  }
}

class EventDetailsInfoTile extends StatelessWidget 
{
  EventDetailsInfoTile
  (
    {
      super.key,
      required this.sectionName,
    }
  );
  final String sectionName;
  final TextEditingController name = TextEditingController();

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
          // side: BorderSide
          // (
          //   color: Theme.of(context).colorScheme.primary,
          //   width: 2.0
          // ),
          borderRadius: BorderRadius.circular(20.0)
        ),
        tileColor: Colors.white,
        title: Text
        (
          sectionName,
          style: TextStyle
          (
            fontSize: 30.0
          ),
        ),
        trailing: IconButton
        (
          icon: Icon
          (
            Icons.edit,
            size: 30.0,
            color: Colors.grey
          ),
          onPressed: () async 
          {
            return showDialog<void>
            (
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) 
              {
                final TextEditingController EventName = TextEditingController();
                return AlertDialog
                (
                  title: const Text('Edit Event Name'),
                  content: TextField
                  (
                    controller: EventName,
                    decoration: InputDecoration
                    (
                      labelText: 'Name',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  actions: <Widget>
                  [
                    TextButton
                    (
                      child: const Text('Cancel'),
                      onPressed: () 
                      {
                        Navigator.pop(context, 'Cancel');
                      },
                    ),
                    TextButton
                    (
                      child: const Text('Save'),
                      onPressed: () 
                      {
                        Navigator.pop(context, 'Save');
                        final updateEventNameSnackBarMessage = SnackBar
                        (
                          content: Text
                          (
                            'Event name updated.',
                            style: TextStyle
                            (
                              color: Colors.white,
                              fontSize: 20.0
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(updateEventNameSnackBarMessage);
                      },
                    ),
                  ],
                );
              },
            );
          }, 
        )
      ),
    );
  }
}