import 'package:cloud_firestore/cloud_firestore.dart';

class Registration 
{
  final String eventId;
  final String attendeeId;
  final String attendeeName;
  final String attendeeEmail;
  final int? attendeePhoneNumber; //Add to WhatsApp Group
  final String? attendeeCNIC;
  final bool attended;

  Registration
  (
    {
      required this.eventId,
      required this.attendeeId,
      required this.attendeeName,
      required this.attendeeEmail,
      required this.attendeePhoneNumber,
      required this.attendeeCNIC,
      required this.attended
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'eventId': eventId,
    'attendeeId': attendeeId, 
    'attendeeName': attendeeName,
    'attendeeEmail': attendeeEmail,
    'attendeePhoneNumber': attendeePhoneNumber,
    'attendeeCNIC': attendeeCNIC,
    'attended': attended
  };

  static Registration fromJson(Map<String, dynamic> json) 
  {
    return Registration
    (
      eventId: json['eventId'],
      attendeeId: json['attendeeId'], 
      attendeeName: json['attendeeName'], 
      attendeeEmail: json['attendeeEmail'],
      attendeePhoneNumber: json['attendeePhoneNumber'],
      attendeeCNIC: json['attendeeCNIC'],
      attended: json['attended']
    );
  }

  factory Registration.fromDoc(DocumentSnapshot RegistrationDoc)
  {
    final RegistrationData = RegistrationDoc.data() as Map<String, dynamic>?;
    return Registration
    (
      eventId: RegistrationData!['eventId'],
      attendeeId: RegistrationData!['attendeeId'], 
      attendeeName: RegistrationData!['attendeeName'], 
      attendeeEmail: RegistrationData!['attendeeEmail'],
      attendeePhoneNumber: RegistrationData!['attendeePhoneNumber'],
      attendeeCNIC: RegistrationData!['attendeeCNIC'],
      attended: RegistrationData!['attended']
    );
  }

  factory Registration.initial()
  {
    return Registration
    (
      eventId: '',
      attendeeId: '', 
      attendeeName: '',
      attendeeEmail: '',
      attendeePhoneNumber: 0,
      attendeeCNIC: '',
      attended: false
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    return [eventId, attendeeId, attendeeName, attendeeEmail, attendeePhoneNumber, attendeeCNIC, attended];
  }

  Registration copyWith
  (
    {
      String? eventId,
      String? attendeeId,
      String? attendeeName,
      String? attendeeEmail,
      int? attendeePhoneNumber,
      String? attendeeCNIC,
      bool? attended
    }
  )
  {
    return Registration
    (
      eventId: eventId ?? this.eventId,
      attendeeId: attendeeId ?? this.attendeeId,
      attendeeName: attendeeName ?? this.attendeeName,
      attendeeEmail: attendeeEmail ?? this.attendeeEmail,
      attendeePhoneNumber: attendeePhoneNumber ?? this.attendeePhoneNumber,
      attendeeCNIC: attendeeCNIC ?? this.attendeeCNIC,
      attended: attended ?? this.attended
    );
  }

  static Registration fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return Registration
    (
      eventId: snapshot['eventId'],
      attendeeId: snapshot['attendeeId'], 
      attendeeName: snapshot['attendeeName'], 
      attendeeEmail: snapshot['attendeeEmail'],
      attendeePhoneNumber: snapshot['attendeePhoneNumber'],
      attendeeCNIC: snapshot['attendeeCNIC'],
      attended: snapshot['attended']
    );
  }
}
