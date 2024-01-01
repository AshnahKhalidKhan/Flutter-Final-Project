import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/Core/Repositories/GDSCLeadsMembersListRepository.dart';
import 'package:flutter_final_project/models/EventModel.dart';
import 'package:flutter_final_project/models/UserModel.dart';

class EventsListRepository 
{
  final FirebaseFirestore firebaseFirestore;
  EventsListRepository({required this.firebaseFirestore});

  Future<void> createEventFunctionInEventRepositoryFile
  (
    {
      required String campusId,
      required String eventName,
      required String date,
      required String startTime,
      required String endTime,
      required String location
    }
  )
  async 
  {
    try 
    {
      final String eventId = FirebaseFirestore.instance.collection('Events').doc().id;
      final Event newEvent = Event
      (
        campusId: campusId,
        eventId: eventId, 
        eventName: eventName, 
        date: date,
        startTime: startTime,
        endTime: endTime,
        location: location,
        hashtags: [],
        registrationFormLink: '',
        streamingLink: '',
        whatsappGroupLink: ''
      );
      await FirebaseFirestore.instance.collection('Events').doc().set(newEvent.toJson());
    }
    catch (e) 
    {
      print('Error in EventRepository, createEvent: $e');
    }
  }

  Stream<List<Event>> readEventFunctionInEventRepositoryFile(String campusId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Events').where('campusId', isEqualTo: campusId).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Event.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in EventRepository, readEvent: $e');
      return Stream<List<Event>>.empty();
    }
  }

  // Stream<List<Event>> readEventFunctionInEventRepositoryFile(String userId) 
  // {
  //   try 
  //   {
  //     return FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: userId).snapshots().asyncMap((userSnapshot) async* 
  //     {
  //       if (userSnapshot.size == 0) 
  //       {
  //         yield []; // No user found, yield an empty list of events
  //         return;
  //       }
  //       final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
  //       final AppUser user = AppUser
  //       (
  //         id: userData['id'],
  //         name: userData['name'],
  //         email: userData['email'],
  //         role: userData['role'],
  //         campus: userData['campus'],
  //         approved: userData['approved'],
  //       );
  //       final eventsSnapshot = await FirebaseFirestore.instance.collection('EventsList').where('campusId', isEqualTo: user.campus).get();
  //       yield eventsSnapshot.docs.map((eventDoc) 
  //       {
  //         final eventData = eventDoc.data() as Map<String, dynamic>;
  //         return Event
  //         (
  //           campusId: eventData['campusId'],
  //           eventId: eventData['eventId'],
  //           eventName: eventData['eventName'],
  //           date: eventData['date'],
  //           startTime: eventData['startTime'],
  //           endTime: eventData['endTime'],
  //           location: eventData['location'],
  //           hashtags: List<String>.from(eventData['hashtags']),
  //           registrationFormLink: eventData['registrationFormLink'],
  //           streamingLink: eventData['streamingLink'],
  //           whatsappGroupLink: eventData['whatsappGroupLink'],
  //         );
  //       }).toList();
  //     } as FutureOr<List<Event>> Function(QuerySnapshot<Map<String, dynamic>> event));
  //   }
  //   catch (e) 
  //   {
  //     print('Error in EventRepository, readEvent: $e');
  //     return Stream<List<Event>>.empty();
  //   }
  // }

  Future<Stream<List<Event>>> readAllEventsOfOneCampusUsingUserIdOfMemberFunctionInRepositoryFile(String userId) async
  {
    try 
    {
      final userFromFirebase = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: userId).get();
      if (userFromFirebase != null)
      {
        String campusId = userFromFirebase.docs.first.data()['campus'];
        print(campusId);
        return FirebaseFirestore.instance.collection('Events').where('campusId', isEqualTo: campusId).snapshots().map
        (
          (querySnapshot) =>
          querySnapshot.docs.map((e) => Event.fromSnapshot(e)).toList()
        );
      }
      return Stream<List<Event>>.empty();
    } 
    catch (e) 
    {
      print('Error in EventRepository, readAllEventsOfOneCampusUsingUserId: $e');
      return Stream<List<Event>>.empty();
    }
  }


  Future<Event?> readOneEventFunctionInEventRepositoryFile(String eventId) async 
  {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Events').where('eventId', isEqualTo: eventId).limit(1).get();
    if (snapshot.docs.isNotEmpty) 
    {
      return Event.fromSnapshot(snapshot.docs.first);
    } 
    else 
    {
      return null;
    }
  }

  Future<void> updateEventFunctionInEventRepositoryFile(Event event)
  async 
  {
    try 
    {
      final updatedEvent = Event
      (
        campusId: event.campusId,
        eventId: event.eventId, 
        eventName: event.eventName, 
        date: event.date,
        startTime: event.startTime,
        endTime: event.endTime,
        location: event.location,
        hashtags: event.hashtags,
        registrationFormLink: event.registrationFormLink,
        streamingLink: event.streamingLink,
        whatsappGroupLink: event.whatsappGroupLink
      ).toJson();
      await FirebaseFirestore.instance.collection('Events').doc(event.eventId).update(updatedEvent);
    }
    catch (e) 
    {
      print('Error in EventRepository, updateEvent: $e');
    }
  }

  Future<void> deleteEventFunctionInEventRepositoryFile(String eventId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('Events').doc(eventId).delete();
    }
    catch (e) 
    {
      print('Error in EventRepository, deleteEvent: $e');
    }
  }
}