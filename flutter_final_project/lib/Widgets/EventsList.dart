import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventsList extends StatefulWidget 
{
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> 
{
  final String x = '40characterslongemailofperson323436...';

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
          'Events', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large
      (
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: EventAddButton()
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: ListView.builder
        (
          itemCount: 10,
          itemBuilder: (context, i)
          {
            return EventListTile(context);
          }
        ),
      )
    );
  }

  Padding EventListTile(BuildContext context) 
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
          'Web Developmemt Bootcamp Session 2',
          style: TextStyle
          (
            fontSize: 20.0
          ),
        ),
        subtitle: Row
        (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: 
          [
            Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: 
              [
                Text
                (
                  '12 Novemeber 2023'.characters.take(25).toString(),
                  style: TextStyle
                  (
                    fontSize: 15.0
                  ),
                ),
                Text
                (
                  '12:00 PM to 9:00 PM'.characters.take(25).toString(),
                  style: TextStyle
                  (
                    fontSize: 15.0
                  ),
                ),
              ],
            ),
            IconButton
            (
              icon: Icon
              (
                Icons.keyboard_arrow_right_outlined,
                size: 40.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () 
              {
                // EventTileBottomSheet(context);
              },
            ),
          ],
        ),
        onTap: () 
        {
          EventTileBottomSheet(context);
        },
      ),
    );
  }

  Future<void> EventTileBottomSheet(BuildContext context) 
  {
    return showModalBottomSheet<void>
    (
      context: context, 
      isScrollControlled: true,
      builder: (BuildContext context)
      {
        return SizedBox
        (
          width: double.infinity,
          child: Padding
          (
            padding: EdgeInsets.all(10.0),
            child: ListTile
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              tileColor: Colors.white,
              subtitle: Padding
              (
                padding: EdgeInsets.only(top: 20.0),
                child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: 
                  [
                    EventInfoField(icon: Icons.star, text: 'Event Name From Firebase'),
                    SizedBox(height: 10.0),
                    EventInfoField(icon: Icons.calendar_month_rounded, text: 'Event Date From Firebase'),
                    SizedBox(height: 10.0),
                    EventInfoField(icon: CupertinoIcons.time, text: 'Event Time From Firebase'),
                    SizedBox(height: 10.0),
                    EventInfoField(icon: Icons.location_pin, text: 'Event Venue From Firebase'),
                    SizedBox(height: 10.0),
                    GestureDetector
                    (
                      child: EventInfoField(icon: Icons.link_rounded, text: 'Click to copy Event Registration Link From Firebase'),
                      onTap: ()
                      {
                        final copiedEventLinkSnackBarMessage = SnackBar
                        (
                          content: Text
                          (
                            'Link copied.',
                            style: TextStyle
                            (
                              color: Colors.white,
                              fontSize: 20.0
                            ),
                          ),
                        );
                        Clipboard.setData
                        (
                          ClipboardData
                          (
                            text: 'Event Registration Link From Firebase'
                          )
                        ).then((value)
                        {
                          Navigator.pop(context, 'BottomSheet');
                          ScaffoldMessenger.of(context).showSnackBar(copiedEventLinkSnackBarMessage);
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    // Row
                    // (
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: 
                    //   [
                    //     EventDeleteButton(),
                    //     EventEditButton()
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class EventAddButton extends StatelessWidget 
{
  const EventAddButton
  (
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      style: ButtonStyle
      (
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.add, 
        size: 40.0
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
            final TextEditingController EventEmail = TextEditingController();
            final TextEditingController EventPhoneNumber = TextEditingController();
            final TextEditingController EventCNIC = TextEditingController();

            return AlertDialog
            (
              title: const Text('Add'),
              content: Column
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  TextField
                  (
                    controller: EventName,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventEmail,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventCNIC,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'CNIC',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventPhoneNumber,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                ],
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
                    final updateEventSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Event added.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateEventSnackBarMessage);
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

class EventEditButton extends StatelessWidget 
{
  const EventEditButton
  (
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      style: ButtonStyle
      (
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.edit, 
        size: 30.0
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
            final TextEditingController EventEmail = TextEditingController();
            final TextEditingController EventPhoneNumber = TextEditingController();
            final TextEditingController EventCNIC = TextEditingController();

            return AlertDialog
            (
              title: const Text('Edit'),
              content: Column
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  TextField
                  (
                    controller: EventName,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventEmail,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventCNIC,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'CNIC',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: EventPhoneNumber,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                ],
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
                    Navigator.pop(context, 'BottomSheet');
                    final updateEventSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Event information updated.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateEventSnackBarMessage);
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

class EventDeleteButton extends StatelessWidget 
{
  const EventDeleteButton
  (
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      style: const ButtonStyle
      (
        iconColor: MaterialStatePropertyAll(Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.delete, 
        size: 30.0
      ),
      onPressed: () async 
      {
        return showDialog<void>
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) 
          {
            return AlertDialog
            (
              title: const Text('Delete Event?'),
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
                  child: const Text('OK'),
                  onPressed: () 
                  {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context, 'BottomSheet');
                    final deleteEventSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Event deleted.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(deleteEventSnackBarMessage);
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

class EventInfoField extends StatelessWidget 
{  
  const EventInfoField
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
          size: 40.0,
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
              fontSize: 20.0,
              // color: Colors.black
            ),
          )
        )
      ],
    );
  }
}