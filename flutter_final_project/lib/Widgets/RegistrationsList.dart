import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationsList extends StatefulWidget 
{
  const RegistrationsList({super.key});

  @override
  State<RegistrationsList> createState() => _RegistrationsListState();
}

class _RegistrationsListState extends State<RegistrationsList> 
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
          'Registrations', 
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
        child: AttendeeAddButton()
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: ListView.builder
        (
          itemCount: 10,
          itemBuilder: (context, i)
          {
            return AttendeeListTile(context);
          }
        ),
      )
    );
  }

  Padding AttendeeListTile(BuildContext context) 
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
          'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'.characters.take(18).toString() + '...', 
          style: TextStyle
          (
            fontSize: 20.0
          ),
        ),
        subtitle: Text
        (
          x.length <= 2 ? x : 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'.characters.take(25).toString() + '...',
          style: TextStyle
          (
            fontSize: 15.0
          ),
        ),
        trailing: Icon
        (
          Icons.expand_more,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () 
        {
          AttendeeTileBottomSheet(context);
        },
      ),
    );
  }

  Future<void> AttendeeTileBottomSheet(BuildContext context) 
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
                    AttendeeInfoField(icon: Icons.person, text: 'Name From Firebase'),
                    SizedBox(height: 10.0),
                    AttendeeInfoField(icon: Icons.email, text: 'Email From Firebase'),
                    SizedBox(height: 10.0),
                    AttendeeInfoField(icon: CupertinoIcons.creditcard, text: 'CNIC From Firebase'),
                    SizedBox(height: 10.0),
                    AttendeeInfoField(icon: Icons.phone, text: 'PhoneNumber From Firebase'),
                    SizedBox(height: 20.0),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: 
                      [
                        AttendeeDeleteButton(),
                        AttendeeEditButton()
                      ],
                    ),
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

class AttendeeAddButton extends StatelessWidget 
{
  const AttendeeAddButton
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
            final TextEditingController attendeeName = TextEditingController();
            final TextEditingController attendeeEmail = TextEditingController();
            final TextEditingController attendeePhoneNumber = TextEditingController();
            final TextEditingController attendeeCNIC = TextEditingController();

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
                    controller: attendeeName,
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
                    controller: attendeeEmail,
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
                    controller: attendeeCNIC,
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
                    controller: attendeePhoneNumber,
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
                    final updateAttendeeSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Attendee added.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateAttendeeSnackBarMessage);
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

class AttendeeEditButton extends StatelessWidget 
{
  const AttendeeEditButton
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
            final TextEditingController attendeeName = TextEditingController();
            final TextEditingController attendeeEmail = TextEditingController();
            final TextEditingController attendeePhoneNumber = TextEditingController();
            final TextEditingController attendeeCNIC = TextEditingController();

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
                    controller: attendeeName,
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
                    controller: attendeeEmail,
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
                    controller: attendeeCNIC,
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
                    controller: attendeePhoneNumber,
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
                    final updateAttendeeSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Attendee information updated.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateAttendeeSnackBarMessage);
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

class AttendeeDeleteButton extends StatelessWidget 
{
  const AttendeeDeleteButton
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
              title: const Text('Delete attendee?'),
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
                    final deleteAttendeeSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'Attendee deleted.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(deleteAttendeeSnackBarMessage);
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

class AttendeeInfoField extends StatelessWidget 
{  
  const AttendeeInfoField
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