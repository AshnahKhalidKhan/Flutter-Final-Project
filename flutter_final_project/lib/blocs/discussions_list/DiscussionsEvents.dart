import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/DiscussionsModel.dart';

abstract class DiscussionsEvent extends Equatable
{
  const DiscussionsEvent();
  List<Object> get props => [];
}

class CreateDiscussionEvent extends DiscussionsEvent 
{
  final String eventId;
  final DateTime timestamp;
  final String senderId;
  final String message;
  
  const CreateDiscussionEvent(this.eventId, this.timestamp, this.senderId, this.message);

  @override
  List<Object> get props => [eventId, timestamp, senderId, message];
}

// class ReadDiscussionEvent extends DiscussionsEvent 
// {
//   @override
//   List<Object> get props => throw UnimplementedError();
// }

class ReadDiscussionEvent extends DiscussionsEvent 
{
  final String eventId;

  const ReadDiscussionEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class UpdateDiscussionEvent extends DiscussionsEvent
{
  final Discussion discussion;

  const UpdateDiscussionEvent(this.discussion);
  
  @override
  List<Object> get props => [discussion];
}

class DeleteDiscussionEvent extends DiscussionsEvent
{
  final String discussionId;

  const DeleteDiscussionEvent(this.discussionId);
  
  @override
  List<Object> get props => [discussionId];
}