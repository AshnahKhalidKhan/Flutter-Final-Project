import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/models/RegistrationsModel.dart';

class RegistrationsListRepository 
{
  final FirebaseFirestore firebaseFirestore;
  RegistrationsListRepository({required this.firebaseFirestore});

  Future<void> createRegistrationFunctionInRegistrationRepositoryFile
  (
    {
      required String eventId,
      required String attendeeName,
      required String attendeeEmail,
      required int? attendeePhoneNumber, //Add to WhatsApp Group
      required String? attendeeCNIC,
    }
  )
  async 
  {
    try 
    {
      final String attendeeId = FirebaseFirestore.instance.collection('RegistrationsList').doc().id;
      final Registration newRegistration = Registration
      (
        eventId: eventId,
        attendeeId: attendeeId, 
        attendeeName: attendeeName, 
        attendeeEmail: attendeeEmail,
        attendeePhoneNumber: attendeePhoneNumber,
        attendeeCNIC: attendeeCNIC,
        attended: false
      );
      await FirebaseFirestore.instance.collection('RegistrationsList').doc().set(newRegistration.toJson());
    }
    catch (e) 
    {
      print('Error in RegistrationRepository, createRegistration: $e');
    }
  }

  Stream<List<Registration>> readRegistrationFunctionInRegistrationRepositoryFile(String eventId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('RegistrationsList').where('eventId', isEqualTo: eventId).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Registration.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in RegistrationRepository, readRegistration: $e');
      return Stream<List<Registration>>.empty();
    }
  }

  Future<void> updateRegistrationFunctionInRegistrationRepositoryFile(Registration registration)
  async 
  {
    try 
    {
      final updatedRegistration = Registration
      (
        eventId: registration.eventId,
        attendeeId: registration.attendeeId, 
        attendeeName: registration.attendeeName, 
        attendeeEmail: registration.attendeeEmail,
        attendeePhoneNumber: registration.attendeePhoneNumber,
        attendeeCNIC: registration.attendeeCNIC,
        attended: registration.attended
      ).toJson();
      await FirebaseFirestore.instance.collection('RegistrationsList').doc(registration.attendeeId).update(updatedRegistration);
    }
    catch (e) 
    {
      print('Error in RegistrationRepository, updateRegistration: $e');
    }
  }

  Future<void> deleteRegistrationFunctionInRegistrationRepositoryFile(String attendeeId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('RegistrationsList').doc(attendeeId).delete();
    }
    catch (e) 
    {
      print('Error in RegistrationRepository, deleteRegistration: $e');
    }
  }
}