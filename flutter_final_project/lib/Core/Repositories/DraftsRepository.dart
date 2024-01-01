import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/models/draft_model.dart';

class DraftsRepository
{
  final FirebaseFirestore firebaseFirestore;
  DraftsRepository({required this.firebaseFirestore});

  Future<void> createDraftFunctionInDraftRepositoryFile
  (
    {
      required String eventId,
      required String platform,
      required String content,
      required String scheduledDate,
      required String scheduledTime,
    }
  )
  async 
  {
    try 
    {
      final String draftId = FirebaseFirestore.instance.collection('DraftsList').doc().id;
      final Draft newDraft = Draft
      (
        eventId: eventId,
        draftId: draftId, 
        platform: platform, 
        content: content,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        attachments: []
      );
      await FirebaseFirestore.instance.collection('DraftsList').doc().set(newDraft.toJson());
    }
    catch (e) 
    {
      print('Error in DraftRepository, createDraft: $e');
    }
  }

  Stream<List<Draft>> readDraftFunctionInDraftRepositoryFile(String eventId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('DraftsList').where('eventId', isEqualTo: eventId).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Draft.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in DraftRepository, readDraft: $e');
      return Stream<List<Draft>>.empty();
    }
  }

  Future<void> updateDraftFunctionInDraftRepositoryFile(Draft draft)
  async 
  {
    try 
    {
      final updatedDraft = Draft
      (
        eventId: draft.eventId,
        draftId: draft.draftId, 
        platform: draft.platform, 
        content: draft.content,
        scheduledDate: draft.scheduledDate,
        scheduledTime: draft.scheduledTime,
        attachments: draft.attachments
      ).toJson();
      await FirebaseFirestore.instance.collection('DraftsList').doc(draft.draftId).update(updatedDraft);
    }
    catch (e) 
    {
      print('Error in DraftRepository, updateDraft: $e');
    }
  }

  Future<void> deleteDraftFunctionInDraftRepositoryFile(String draftId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('DraftsList').doc(draftId).delete();
    }
    catch (e) 
    {
      print('Error in DraftRepository, deleteDraft: $e');
    }
  }
}