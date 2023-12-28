import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';

class GDSCCampusesRepository 
{
  final FirebaseFirestore firebaseFirestore;
  GDSCCampusesRepository({required this.firebaseFirestore});

  Future<void> createGDSCCampusFunctionInGDSCCampusesRepositoryFile
  (
    {
      required String campusId,
      required String campusName,
      required String email,
      required String location,
    }
  )
  async 
  {
    try 
    {
      final String campusId = FirebaseFirestore.instance.collection('GDSCCampus').doc().id;
      final GDSCCampus newGDSCCampus = GDSCCampus
      (
        campusId: campusId, 
        campusName: campusName, 
        email: email,
        location: location,
        lead: '',
      );
      await FirebaseFirestore.instance.collection('GDSCCampus').doc().set(newGDSCCampus.toJson());
    }
    catch (e) 
    {
      print('Error in GDSCCampusesRepository, createGDSCCampus: $e');
    }
  }

  Stream<List<GDSCCampus>> readGDSCCampusFunctionInGDSCCampusesRepositoryFile(String campusId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('GDSCCampus').where('campusId', isEqualTo: campusId).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => GDSCCampus.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCCampusesRepository, readGDSCCampus: $e');
      return Stream<List<GDSCCampus>>.empty();
    }
  }

  Stream<List<GDSCCampus>> allGDSCCampusesFunctionInGDSCCampusesRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('GDSCCampus').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => GDSCCampus.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCCampusesRepository, readGDSCCampus: $e');
      return Stream<List<GDSCCampus>>.empty();
    }
  }

  Future<void> updateGDSCCampusFunctionInGDSCCampusesRepositoryFile(GDSCCampus campus)
  async 
  {
    try 
    {
      final updateGDSCCampus = GDSCCampus
      (
        campusId: campus.campusId,
        campusName: campus.campusName, 
        email: campus.email,
        location: campus.location,
        lead: campus.lead,
      ).toJson();
      await FirebaseFirestore.instance.collection('GDSCCampus').doc(campus.campusId).update(updateGDSCCampus);
    }
    catch (e) 
    {
      print('Error in GDSCCampusesRepository, updateGDSCCampus: $e');
    }
  }

  Future<void> deleteGDSCCampusFunctionInGDSCCampusesRepositoryFile(String campusId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('GDSCCampus').doc(campusId).delete();
    }
    catch (e) 
    {
      print('Error in GDSCCampusesRepository, deleteGDSCCampus: $e');
    }
  }
}