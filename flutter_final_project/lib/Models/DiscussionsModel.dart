import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Discussion extends Equatable
{
  final String discussionId; //same as eventId
  final DateTime timestamp;
  final String senderId;
  final String message;

  const Discussion
  (
    {
      required this.discussionId,
      required this.timestamp,
      required this.senderId,
      required this.message,
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'discussionId': discussionId,
    'timestamp': timestamp, 
    'senderId': senderId,
    'message': message
  };

  static Discussion fromJson(Map<String, dynamic> json) 
  {
    return Discussion
    (
      discussionId: json['discussionId'],
      timestamp: json['timestamp'], 
      senderId: json['senderId'], 
      message: json['message']
    );
  }

  factory Discussion.fromDoc(DocumentSnapshot DiscussionDoc)
  {
    final DiscussionData = DiscussionDoc.data() as Map<String, dynamic>?;
    return Discussion
    (
      discussionId: DiscussionData!['discussionId'],
      timestamp: DiscussionData!['timestamp'], 
      senderId: DiscussionData!['senderId'], 
      message: DiscussionData!['message']
    );
  }

  factory Discussion.initial()
  {
    return Discussion
    (
      discussionId: '',
      timestamp: DateTime.now(), 
      senderId: '',
      message: ''
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    return [discussionId, timestamp, senderId, message];
  }

  Discussion copyWith
  (
    {
      String? discussionId,
      DateTime? timestamp,
      String? senderId,
      String? message
    }
  )
  {
    return Discussion
    (
      discussionId: discussionId ?? this.discussionId,
      timestamp: timestamp ?? this.timestamp,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message
    );
  }

  static Discussion fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return Discussion
    (
      discussionId: snapshot['discussionId'],
      timestamp: snapshot['timestamp'], 
      senderId: snapshot['senderId'], 
      message: snapshot['message']
    );
  }
}
