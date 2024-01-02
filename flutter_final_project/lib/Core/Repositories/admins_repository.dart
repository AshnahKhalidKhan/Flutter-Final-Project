import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final_project/models/user_model.dart';

class AdminsRepository 
{
  final FirebaseFirestore firebaseFirestore;
  AdminsRepository({required this.firebaseFirestore});

  Future<void> createAdminFunctionInAdminsRepositoryFile
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
      final String adminId = FirebaseFirestore.instance.collection('Users').doc().id;
      final AppUser newAdmin = AppUser
      (
        id: adminId, 
        name: name, 
        email: email,
        role: role,
        campus: '',
        approved: false
      );
      await FirebaseFirestore.instance.collection('Users').doc().set(newAdmin.toJson());
    }
    catch (e) 
    {
      throw Exception('Unable to create admin. Please try again.\n $e');
    }
  }

  Future<AppUser?> readOneAdminFunctionInAdminsRepositoryFile(String userId) async 
  {
    try 
    {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: userId).limit(1).get();
      if (snapshot.docs.isNotEmpty) 
      {
        return AppUser.fromSnapshot(snapshot.docs.first);
      } 
    } 
    catch (e) 
    {
      throw Exception('Unable to load admin details. Please try again.\n $e');
    }
  }

  Stream<List<AppUser>> readAllAdminsFunctionInAdminsRepositoryFile() 
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
      throw Exception('Unable to load admins list. Please try again.\n $e');
    }
  }

  Future<void> updateAdminFunctionInAdminsRepositoryFile(AppUser admin)
  async 
  {
    try 
    {
      final Map<String, dynamic> updateAdmin = AppUser
      (
        id: admin.id,
        name: admin.name, 
        email: admin.email,
        role: admin.role,
        campus: admin.campus,
        approved: admin.approved
      ).toJson();
      final snapshot = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: admin.id).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Users').doc(snapshot.docs.first.id).update(updateAdmin);
      }
    }
    catch (e) 
    {
      throw Exception('Unable to edit admin details. Please try again.\n $e');
    }
  }

  Future<void> deleteAdminFunctionInAdminsRepositoryFile(String adminId)
  async 
  {
    try 
    {
      final snapshot = await FirebaseFirestore.instance.collection('Users').where('id', isEqualTo: adminId).get();
      if (snapshot.docs.isNotEmpty) 
      {
        await FirebaseFirestore.instance.collection('Users').doc(snapshot.docs.first.id).delete();
      }
    }
    catch (e) 
    {
      throw Exception('Unable to delete admin. Please try again.\n $e');
    }
  }
}