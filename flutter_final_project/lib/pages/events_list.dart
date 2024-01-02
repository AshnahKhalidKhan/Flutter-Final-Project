import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_final_project/blocs/events_list/EventsListBloc.dart';
import 'package:flutter_final_project/blocs/events_list/EventsListEvents.dart';
import 'package:flutter_final_project/blocs/events_list/EventsListStates.dart';
import 'package:flutter_final_project/models/event_model.dart';
import 'package:flutter_final_project/pages/event_details.dart';
import 'package:flutter_final_project/reusable_widgets_constants/snack_bar.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> 
{
  @override
  void initState() {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final ArahahaiUser = authenticationBloc.signedInUser;
    BlocProvider.of<EventsListBloc>(context).add(
        ReadAllEventsOfOneCampusUsingUserIdLoadedEvent(ArahahaiUser!.campus!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final ArahahaiUser = authenticationBloc.signedInUser;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading:
              Icon(Icons.event_note_rounded, color: Colors.white, size: 30.0),
          title: const Text(
            'Events',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {},
            shape: CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: EventAddButton()),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(ArahahaiUser!.id.toString()),
              Text(ArahahaiUser!.name.toString()),
              Text(ArahahaiUser!.email.toString()),
              Text(ArahahaiUser!.campus.toString()),
              Text(ArahahaiUser!.approved.toString()),
              Text(ArahahaiUser!.id.toString()),
              BlocBuilder<EventsListBloc, EventsListState>(
                builder: (context, state) {
                  if (state is EventsListLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is EventsListErrorState) {
                    return Center(child: Text(state.error));
                  } else if (state
                      is AllEventsOfOneCampusUsingUserIdLoadedState) {
                    return StreamBuilder<List<Event>>(
                        stream: state.event,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return EventListTile(
                                        context, snapshot.data![index]);
                                  }),
                            );
                          } else {
                            return Center(child: Text('Snapshot has no data.'));
                          }
                        });
                  } else {
                    return Text('Not working');
                  }
                  //     else if (state is AllEventsOfOneCampusUsingUserIdLoadedState)
                  //     {
                  //       return FutureBuilder
                  //       (
                  //         future: state.event,
                  //         builder: (context, snapshot)
                  //         {
                  //           if (snapshot.hasData)
                  //           {
                  //             return StreamBuilder
                  //             (
                  //               stream: snapshot.data,
                  //               builder: (context, event)
                  //               {
                  //                 if (event.hasData)
                  //                 {
                  //                   return Expanded
                  //                   (
                  //                     child: ListView.builder
                  //                     (
                  //                       itemCount: event.data!.length,
                  //                       itemBuilder: (context, index)
                  //                       {
                  //                         // return Text(event.data![index].eventName);
                  //                         return EventListTile(context, event.data![index]);
                  //                       }
                  //                     ),
                  //                   );
                  //                 }
                  //                 else
                  //                 {
                  //                   return Text('evnet.hasdata mein uch nahin araha');
                  //                 }
                  //               }
                  //             );
                  //           }
                  //           else
                  //           {
                  //             return Text('snapshot.hasdata mein kuch nahin');
                  //           }
                  //         }
                  //       );
                  //     }
                  //     else
                  //     {
                  //       return Center(child: Text('Unable to load events list at the moment. Please try later.'));
                  //     }
                },
              ),
            ],
          ),
        ));
  }

  Padding EventListTile(BuildContext context, Event event) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        tileColor: Colors.white,
        style: ListTileStyle.list,
        title: Text(
          event.eventName,
          style: TextStyle(fontSize: 20.0),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.date,
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  (event.startTime + ' to ' + event.endTime),
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 40.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.pushNamed
                (
                  context,
                  '/Event',
                  arguments: event.eventId,
                );
              },
            ),
          ],
        ),
        onTap: () {
          EventTileBottomSheet(context, event);
        },
      ),
    );
  }

  Future<void> EventTileBottomSheet(BuildContext context, Event event) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor: Colors.white,
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EventInfoField(icon: Icons.star, text: event.eventName),
                      SizedBox(height: 10.0),
                      EventInfoField(
                          icon: Icons.calendar_month_rounded, text: event.date),
                      SizedBox(height: 10.0),
                      EventInfoField(
                          icon: CupertinoIcons.time,
                          text: event.startTime + ' to ' + event.endTime),
                      SizedBox(height: 10.0),
                      EventInfoField(
                          icon: Icons.location_pin, text: event.location),
                      SizedBox(height: 10.0),
                      GestureDetector(
                        child: EventInfoField(
                            icon: Icons.link_rounded,
                            text:
                                'Click to copy Event Registration Link From Firebase'),
                        onTap: () {
                          final copiedEventLinkSnackBarMessage = SnackBar(
                            content: Text(
                              'Link copied.',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          );
                          Clipboard.setData(ClipboardData(
                                  text: event.registrationFormLink!))
                              .then((value) {
                            Navigator.pop(context, 'BottomSheet');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(copiedEventLinkSnackBarMessage);
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class EventAddButton extends StatelessWidget {
  const EventAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.add, size: 40.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final TextEditingController EventName = TextEditingController();
            final TextEditingController EventEmail = TextEditingController();
            final TextEditingController EventPhoneNumber =
                TextEditingController();
            final TextEditingController EventCNIC = TextEditingController();

            return AlertDialog(
              title: const Text('Add'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: EventName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventCNIC,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'CNIC',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventPhoneNumber,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Navigator.pop(context, 'Save');
                    final updateEventSnackBarMessage = SnackBar(
                      content: Text(
                        'Event added.',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(updateEventSnackBarMessage);
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

class EventEditButton extends StatelessWidget {
  const EventEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.edit, size: 30.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            final TextEditingController EventName = TextEditingController();
            final TextEditingController EventEmail = TextEditingController();
            final TextEditingController EventPhoneNumber =
                TextEditingController();
            final TextEditingController EventCNIC = TextEditingController();

            return AlertDialog(
              title: const Text('Edit'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: EventName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventCNIC,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'CNIC',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                  TextField(
                    controller: EventPhoneNumber,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (value) {
                      //
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    Navigator.pop(context, 'Save');
                    Navigator.pop(context, 'BottomSheet');
                    final updateEventSnackBarMessage = SnackBar(
                      content: Text(
                        'Event information updated.',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    );
                    ScaffoldMessenger.of(context)
                        .showSnackBar(updateEventSnackBarMessage);
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

class EventDeleteButton extends StatelessWidget {
  const EventDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: const ButtonStyle(
        iconColor: MaterialStatePropertyAll(Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.delete, size: 30.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Event?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context, 'BottomSheet');
                    final deleteEventSnackBarMessage = SnackBar(
                      content: Text(
                        'Event deleted.',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    );
                    // final deleteEventSnackBarMessage = MySnackBar(snackBarMessage: 'Event deleted');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(deleteEventSnackBarMessage as SnackBar);
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

class EventInfoField extends StatelessWidget {
  const EventInfoField({
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
        Icon(icon, size: 40.0, color: Theme.of(context).colorScheme.primary),
        SizedBox(width: 10.0),
        Expanded(
            child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            // color: Colors.black
          ),
        ))
      ],
    );
  }
}
