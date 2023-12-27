import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/Models/DiscussionsModel.dart';

class DiscussionsRepository 
{
  final FirebaseFirestore firebaseFirestore;
  DiscussionsRepository({required this.firebaseFirestore});

  Future<void> createDiscussionFunctionInDiscussionRepositoryFile
  (
    {
      required String discussionId,
      required DateTime timestamp,
      required String senderId,
      required String message,
    }
  )
  async 
  {
    try 
    {
      final Discussion newDiscussion = Discussion
      (
        discussionId: discussionId, 
        timestamp: timestamp, 
        senderId: senderId, 
        message: message
      );
      await FirebaseFirestore.instance.collection('Discussions').doc().set(newDiscussion.toJson());
    }
    catch (e) 
    {
      print('Error in DiscussionRepository, createDiscussion: $e');
    }
  }

  Stream<List<Discussion>> readDiscussionFunctionInDiscussionRepositoryFile(String discussionId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Discussions').snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Discussion.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in DiscussionRepository, readDiscussion: $e');
      return Stream<List<Discussion>>.empty();
    }
  }

  Future<void> updateDiscussionFunctionInDiscussionRepositoryFile(Discussion discussion)
  async 
  {
    try 
    {
      final updatedDiscussion = Discussion
      (
        discussionId: discussion.discussionId, 
        timestamp: discussion.timestamp, 
        senderId: discussion.senderId, 
        message: discussion.message
      ).toJson();
      await FirebaseFirestore.instance.collection('Discussions').doc(discussion.discussionId).update(updatedDiscussion);
    }
    catch (e) 
    {
      print('Error in DiscussionRepository, updateDiscussion: $e');
    }
  }

  Future<void> deleteDiscussionFunctionInDiscussionRepositoryFile(String discussionId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('Discussions').doc(discussionId).delete();
    }
    catch (e) 
    {
      print('Error in DiscussionRepository, deleteDiscussion: $e');
    }
  }
}