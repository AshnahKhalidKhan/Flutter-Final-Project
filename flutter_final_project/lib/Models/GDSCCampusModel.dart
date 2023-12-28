import 'package:cloud_firestore/cloud_firestore.dart';

class GDSCCampus 
{
  final String campusId;
  final String campusName;
  final String email;
  final String location;
  final String lead;
  // final String? facebookEmail;
  // final String? facebookPassword;
  // final String? instagramEmail;
  // final String? instagramPassword;
  // final String? linkedInEmail;
  // final String? linkedInPassword;

  const GDSCCampus
  (
    {
      required this.campusId,
      required this.campusName,
      required this.email,
      required this.location,
      required this.lead,
      // required this.facebookEmail,
      // required this.facebookPassword,
      // required this.instagramEmail,
      // required this.instagramPassword,
      // required this.linkedInEmail,
      // required this.linkedInPassword
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'campusId': campusId,
    'campusName': campusName, 
    'email': email,
    'location': location,
    'lead': lead,
    // 'facebookEmail': facebookEmail,
    // 'facebookPassword': facebookPassword,
    // 'instagramEmail': instagramEmail,
    // 'instagramPassword': instagramPassword,
    // 'linkedInEmail': linkedInEmail,
    // 'linkedInPassword': linkedInPassword
  };

  static GDSCCampus fromJson(Map<String, dynamic> json) 
  {
    return GDSCCampus
    (
      campusId: json['campusId'],
      campusName: json['campusName'], 
      email: json['email'], 
      location: json['location'],
      lead: json['lead'], 
      // facebookEmail: json['facebookEmail'],
      // facebookPassword: json['facebookPassword'],
      // instagramEmail: json['instagramEmail'],
      // instagramPassword: json['instagramPassword'],
      // linkedInEmail: json['linkedInEmail'],
      // linkedInPassword: json['linkedInPassword']
    );
  }

  factory GDSCCampus.fromDoc(DocumentSnapshot GDSCCampusDoc)
  {
    final GDSCCampusData = GDSCCampusDoc.data() as Map<String, dynamic>?;
    return GDSCCampus
    (
      campusId: GDSCCampusData!['campusId'],
      campusName: GDSCCampusData!['campusName'], 
      email: GDSCCampusData!['email'], 
      location: GDSCCampusData!['location'],
      lead: GDSCCampusData!['lead'], 
      // facebookEmail: GDSCCampusData!['facebookEmail'],
      // facebookPassword: GDSCCampusData!['facebookPassword'],
      // instagramEmail: GDSCCampusData!['instagramEmail'],
      // instagramPassword: GDSCCampusData!['instagramPassword'],
      // linkedInEmail: GDSCCampusData!['linkedInEmail'],
      // linkedInPassword: GDSCCampusData!['linkedInPassword']
    );
  }

  factory GDSCCampus.initial()
  {
    return const GDSCCampus
    (
      campusId: '',
      campusName: '', 
      email: '',
      location: '',
      lead: '',
      // facebookEmail: '',
      // facebookPassword: '',
      // instagramEmail: '',
      // instagramPassword: '',
      // linkedInEmail: '',
      // linkedInPassword: ''

    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    // return [campusId, campusName, email, location, lead, facebookEmail, facebookPassword, instagramEmail, instagramPassword, linkedInEmail, linkedInPassword];
    return [campusId, campusName, email, location, lead];
  }
  
  GDSCCampus copyWith
  (
    {
      String? campusId,
      String? campusName,
      String? email,
      String? location,
      String? lead,
      // String? facebookEmail,
      // String? facebookPassword,
      // String? instagramEmail,
      // String? instagramPassword,
      // String? linkedInEmail,
      // String? linkedInPassword
    }
  )
  {
    return GDSCCampus
    (
      campusId: campusId ?? this.campusId,
      campusName: campusName ?? this.campusName,
      email: email ?? this.email,
      location: location ?? this.location,
      lead: lead ?? this.lead,
      // facebookEmail: facebookEmail ?? this.facebookEmail,
      // facebookPassword: facebookPassword ?? this.facebookPassword,
      // instagramEmail: instagramEmail ?? this.instagramEmail,
      // instagramPassword: instagramPassword ?? this.instagramPassword,
      // linkedInEmail: linkedInEmail ?? this.linkedInEmail,
      // linkedInPassword: linkedInPassword ?? this.linkedInPassword
    );
  }

  static GDSCCampus fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return GDSCCampus
    (
      campusId: snapshot['campusId'],
      campusName: snapshot['campusName'], 
      email: snapshot['email'], 
      location: snapshot['location'],
      lead: snapshot['lead'], 
      // facebookEmail: snapshot['facebookEmail'],
      // facebookPassword: snapshot['facebookPassword'],
      // instagramEmail: snapshot['instagramEmail'],
      // instagramPassword: snapshot['instagramPassword'],
      // linkedInEmail: snapshot['linkedInEmail'],
      // linkedInPassword: snapshot['linkedInPassword']
    );
  }
}
