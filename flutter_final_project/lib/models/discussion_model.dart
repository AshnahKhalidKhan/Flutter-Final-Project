import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Discussion extends Equatable
{
  final String eventId;
  final String discussionId;
  final DateTime timestamp;
  final String senderId;
  final String message;

  const Discussion
  (
    {
      required this.eventId,
      required this.discussionId,
      required this.timestamp,
      required this.senderId,
      required this.message,
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'eventId': eventId,
    'discussionId': discussionId,
    'timestamp': timestamp, 
    'senderId': senderId,
    'message': message
  };

  static Discussion fromJson(Map<String, dynamic> json) 
  {
    return Discussion
    (
      eventId: json['eventId'],
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
      eventId: DiscussionData!['eventId'],
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
      eventId: '',
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
    return [eventId, discussionId, timestamp, senderId, message];
  }

  Discussion copyWith
  (
    {
      String? eventId,
      String? discussionId,
      DateTime? timestamp,
      String? senderId,
      String? message
    }
  )
  {
    return Discussion
    (
      eventId: eventId ?? this.eventId,
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
      eventId: snapshot['eventId'],
      discussionId: snapshot['discussionId'],
      timestamp: snapshot['timestamp'], 
      senderId: snapshot['senderId'], 
      message: snapshot['message']
    );
  }
}
