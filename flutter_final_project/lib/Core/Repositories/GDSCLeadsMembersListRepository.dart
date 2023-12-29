import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

class GDSCLeadsMembersListRepository 
{
  final FirebaseFirestore firebaseFirestore;
  GDSCLeadsMembersListRepository({required this.firebaseFirestore});

  Future<void> createAppUserFunctionInGDSCLeadsMembersListRepositoryFile
  (
    {
      required String name,
      required String email,
      required String role,
    }
  )
  async 
  {
    try 
    {
      final String id = FirebaseFirestore.instance.collection('Users').doc().id;
      final AppUser newAppUser = AppUser
      (
        id: id, 
        name: name, 
        email: email,
        role: role,
        campus: '',
        approved: false
      );
      await FirebaseFirestore.instance.collection('Users').doc().set(newAppUser.toJson());
    }
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, createAppUser: $e');
    }
  }

  Stream<List<AppUser>> readAppUserFunctionInGDSCLeadsMembersListRepositoryFile(String id)
  {
    return FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: id).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => AppUser.fromSnapshot(e)).toList()
      );
  }

  Stream<List<AppUser>> allGDSCLeadsMembersListFunctionInGDSCLeadsMembersListRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Users').orderBy('name').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => AppUser.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, readAppUser: $e');
      return Stream<List<AppUser>>.empty();
    }
  }

  Stream<List<AppUser>> allApprovedGDSCLeadsListFunctionInGDSCLeadsMembersListRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Users').where('role', isEqualTo: 'Lead').where('approved', isEqualTo: true).orderBy('name').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => AppUser.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, readAppUser: $e');
      return Stream<List<AppUser>>.empty();
    }
  }

  Stream<List<AppUser>> allPendingGDSCLeadsListFunctionInGDSCLeadsMembersListRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Users').where('role', isEqualTo: 'Lead').where('approved', isEqualTo: false).orderBy('name').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => AppUser.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, readAppUser: $e');
      return Stream<List<AppUser>>.empty();
    }
  }

  Stream<List<AppUser>> allAdminsListFunctionInGDSCLeadsMembersListRepositoryFile() 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Users').where('role', isEqualTo: 'Admin').orderBy('name').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => AppUser.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, readAppUser: $e');
      return Stream<List<AppUser>>.empty();
    }
  }

  Future<void> approveGDSCLeadFunctionInGDSCLeadsMembersListRepositoryFile(AppUser user)
  async 
  {
    try 
    {
      final AppUser updateAppUser = AppUser
      (
        id: user.id,
        name: user.name, 
        email: user.email,
        role: user.role,
        campus: user.campus,
        approved: true
      );
      updateAppUserFunctionInGDSCLeadsMembersListRepositoryFile(updateAppUser);
    }
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, updateAppUser: $e');
    }
  }

  Future<void> removeGDSCLeadFunctionInGDSCLeadsMembersListRepositoryFile(AppUser user)
  async 
  {
    try 
    {
      final AppUser updateAppUser = AppUser
      (
        id: user.id,
        name: user.name, 
        email: user.email,
        role: user.role,
        campus: user.campus,
        approved: false
      );
      updateAppUserFunctionInGDSCLeadsMembersListRepositoryFile(updateAppUser);
    }
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, updateAppUser: $e');
    }
  }

  Future<void> updateAppUserFunctionInGDSCLeadsMembersListRepositoryFile(AppUser user)
  async 
  {
    try 
    {
      final Map<String, dynamic> updateAppUser = AppUser
      (
        id: user.id,
        name: user.name, 
        email: user.email,
        role: user.role,
        campus: user.campus,
        approved: user.approved
      ).toJson();
      final snapshot = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: user.id).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Users').doc(snapshot.docs.first.id).update(updateAppUser);
      }
    }
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, updateAppUser: $e');
    }
  }

  Future<void> deleteAppUserFunctionInGDSCLeadsMembersListRepositoryFile(String id)
  async 
  {
    try 
    {
      final snapshot = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: id).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Users').doc(snapshot.docs.first.id).delete();
      }
    }
    catch (e) 
    {
      print('Error in GDSCLeadsMembersListRepository, deleteAppUser: $e');
    }
  }
}