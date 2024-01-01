import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Draft extends Equatable
{
  final String eventId;
  final String draftId;
  final String platform;
  final String content;
  final String scheduledDate;
  final String scheduledTime;
  final List<String>? attachments;

  Draft
  (
    {
      required this.eventId,
      required this.draftId,
      required this.platform,
      required this.content,
      required this.scheduledDate,
      required this.scheduledTime,
      required this.attachments,
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'eventId': eventId,
    'draftId': draftId, 
    'platform': platform,
    'content': content,
    'scheduledDate': scheduledDate,
    'scheduledTime': scheduledTime,
    'attachments': attachments
  };

  factory Draft.fromJson(Map<String, dynamic> json) 
  {
    return Draft
    (
      eventId: json['eventId'],
      draftId: json['draftId'],
      platform: json['platform'],
      content: json['content'],
      scheduledDate: json['scheduledDate'],
      scheduledTime: json['scheduledTime'],
      attachments: List<String>.from(json['attachments'])
    );
  }

  @override
  List<Object?> get props
  {
    return [eventId, draftId, platform, content, scheduledDate, scheduledTime, attachments];
  }

  @override
  bool get stringify => true;

  Draft copyWith
  (
    {
      String? eventId,
      String? draftId,
      String? platform,
      String? content,
      String? scheduledDate,
      String? scheduledTime,
      List<String>? attachments
    }
  )
  {
    return Draft
    (
      eventId: eventId ?? this.eventId,
      draftId: draftId ?? this.draftId,
      platform: platform ?? this.platform,
      content: content ?? this.content,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      attachments: attachments ?? this.attachments
    );
  }

  factory Draft.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return Draft
    (
      eventId: snapshot['eventId'],
      draftId: snapshot['draftId'],
      platform: snapshot['platform'],
      content: snapshot['content'],
      scheduledDate: snapshot['scheduledDate'],
      scheduledTime: snapshot['scheduledTime'],
      attachments: List<String>.from(snapshot['attachments'])
    );
  }
}
