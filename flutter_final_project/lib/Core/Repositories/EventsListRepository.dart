import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/Core/Repositories/GDSCLeadsMembersListRepository.dart';
import 'package:flutter_final_project/Models/EventModel.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

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