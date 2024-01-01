import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/models/campus_model.dart';

class CampusesRepository 
{
  final FirebaseFirestore firebaseFirestore;
  CampusesRepository({required this.firebaseFirestore});

  Future<void> createCampusFunctionInCampusesRepositoryFile
  (
    {
      required String campusName,
      required String email,
      required String location,
    }
  )
  async 
  {
    try 
    {
      final String campusId = FirebaseFirestore.instance.collection('Campus').doc().id;
      final Campus newCampus = Campus
      (
        campusId: campusId, 
        campusName: campusName, 
        email: email,
        location: location,
        lead: '',
      );
      await FirebaseFirestore.instance.collection('Campus').doc().set(newCampus.toJson());
    }
    catch (e) 
    {
      throw Exception('Unable to create campus. Please try again.\n $e');
    }
  }

  Stream<List<Campus>> readCampusFunctionInCampusesRepositoryFile(String campusId)
  {
    return FirebaseFirestore.instance.collection('Campus').where('campusId', isEqualTo: campusId).snapshots().map
    (
      (querySnapshot) =>
      querySnapshot.docs.map((e) => Campus.fromSnapshot(e)).toList()
    );
  }

  Future<Campus?> readOneCampusFunctionInCampusesRepositoryFile(String campusId) async 
  {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Campus').where('campusId', isEqualTo: campusId).limit(1).get();
    if (snapshot.docs.isNotEmpty) 
    {
      return Campus.fromSnapshot(snapshot.docs.first);
    } 
    else 
    {
      return null;
    }
  }

  Stream<List<Campus>> allCampusesFunctionInCampusesRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Campus').orderBy('campusName').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Campus.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      throw Exception('Unable to create campus. Please try again.\n $e');
    }
  }

  Future<void> updateCampusFunctionInCampusesRepositoryFile(Campus campus)
  async 
  {
    try 
    {
      final Map<String, dynamic> updateCampus = Campus
      (
        campusId: campus.campusId,
        campusName: campus.campusName, 
        email: campus.email,
        location: campus.location,
        lead: campus.lead,
      ).toJson();
      final snapshot = await FirebaseFirestore.instance.collection('Campus').where('campusId', isEqualTo: campus.campusId).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Campus').doc(snapshot.docs.first.id).update(updateCampus);
      }
    }
    catch (e) 
    {
      throw Exception('Unable to edit campus details. Please try again.\n $e');
    }
  }

  Future<void> deleteCampusFunctionInCampusesRepositoryFile(String campusId)
  async 
  {
    try 
    {
      final snapshot = await FirebaseFirestore.instance.collection('Campus').where('campusId', isEqualTo: campusId).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Campus').doc(snapshot.docs.first.id).delete();
      }
    }
    catch (e) 
    {
      throw Exception('Unable to delete campus. Please try again.\n $e');
    }
  }
}