import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Event extends Equatable
{
  final String campusId;
  final String eventId;
  final String eventName;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  final List<String>? hashtags;
  final String? registrationFormLink;
  final String? streamingLink;
  final String? whatsappGroupLink;

  const Event
  (
    {
      required this.campusId,
      required this.eventId,
      required this.eventName,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.location,
      required this.hashtags,
      required this.registrationFormLink,
      required this.streamingLink,
      required this.whatsappGroupLink,
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'campusId': campusId,
    'eventId': eventId,
    'eventName': eventName, 
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'location': location,
    'hashtags': hashtags,
    'registrationFormLink': registrationFormLink,
    'streamingLink': streamingLink,
    'whatsappGroupLink': whatsappGroupLink
  };

  static Event fromJson(Map<String, dynamic> json) 
  {
    return Event
    (
      campusId: json['campusId'],
      eventId: json['eventId'],
      eventName: json['eventName'], 
      date: json['date'], 
      startTime: json['startTime'],
      endTime: json['endTime'], 
      location: json['location'],
      hashtags: List<String>.from(json['hashtags']),
      registrationFormLink: json['registrationFormLink'],
      streamingLink: json['streamingLink'],
      whatsappGroupLink: json['whatsappGroupLink']
    );
  }

  factory Event.fromDoc(DocumentSnapshot EventDoc)
  {
    final EventData = EventDoc.data() as Map<String, dynamic>?;
    return Event
    (
      campusId: EventData!['campusId'],
      eventId: EventData!['eventId'],
      eventName: EventData!['eventName'], 
      date: EventData!['date'], 
      startTime: EventData!['startTime'],
      endTime: EventData!['endTime'], 
      location: EventData!['location'],
      hashtags: EventData!['hashtags'],
      registrationFormLink: EventData!['registrationFormLink'],
      streamingLink: EventData!['streamingLink'],
      whatsappGroupLink: EventData!['whatsappGroupLink']
    );
  }

  factory Event.initial()
  {
    return const Event
    (
      campusId: '',
      eventId: '',
      eventName: '', 
      date: '',
      startTime: '',
      endTime: '',
      location: '',
      hashtags: [],
      registrationFormLink: '',
      streamingLink: '',
      whatsappGroupLink: ''

    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    return [campusId, eventId, eventName, date, startTime, endTime, location, hashtags, registrationFormLink, streamingLink, whatsappGroupLink];
  }
  
  Event copyWith
  (
    {
      String? campusId,
      String? eventId,
      String? eventName,
      String? date,
      String? startTime,
      String? endTime,
      String? location,
      List<String>? hashtags,
      String? registrationFormLink,
      String? streamingLink,
      String? whatsappGroupLink
    }
  )
  {
    return Event
    (
      campusId: campusId ?? this.campusId,
      eventId: eventId ?? this.eventId,
      eventName: eventName ?? this.eventName,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      hashtags: hashtags ?? this.hashtags,
      registrationFormLink: registrationFormLink ?? this.registrationFormLink,
      streamingLink: streamingLink ?? this.streamingLink,
      whatsappGroupLink: whatsappGroupLink ?? this.whatsappGroupLink
    );
  }

  static Event fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return Event
    (
      campusId: snapshot['campusId'],
      eventId: snapshot['eventId'],
      eventName: snapshot['eventName'], 
      date: snapshot['date'], 
      startTime: snapshot['startTime'],
      endTime: snapshot['endTime'], 
      location: snapshot['location'],
      hashtags: List<String>.from(snapshot['hashtags']),
      registrationFormLink: snapshot['registrationFormLink'],
      streamingLink: snapshot['streamingLink'],
      whatsappGroupLink: snapshot['whatsappGroupLink']
    );
  }
}
