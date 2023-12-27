import 'package:cloud_firestore/cloud_firestore.dart';

class GDSCCampus 
{
  final String id;
  final String name;
  final String email;
  final String location;
  final String lead;
  final String? facebookEmail;
  final String? facebookPassword;
  final String? instagramEmail;
  final String? instagramPassword;
  final String? linkedInEmail;
  final String? linkedInPassword;

  const GDSCCampus
  (
    {
      required this.id,
      required this.name,
      required this.email,
      required this.location,
      required this.lead,
      required this.facebookEmail,
      required this.facebookPassword,
      required this.instagramEmail,
      required this.instagramPassword,
      required this.linkedInEmail,
      required this.linkedInPassword
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'name': name, 
    'email': email,
    'location': location,
    'lead': lead,
    'facebookEmail': facebookEmail,
    'facebookPassword': facebookPassword,
    'instagramEmail': instagramEmail,
    'instagramPassword': instagramPassword,
    'linkedInEmail': linkedInEmail,
    'linkedInPassword': linkedInPassword
  };

  static GDSCCampus fromJson(Map<String, dynamic> json) 
  {
    return GDSCCampus
    (
      id: json['id'],
      name: json['name'], 
      email: json['email'], 
      location: json['location'],
      lead: json['lead'], 
      facebookEmail: json['facebookEmail'],
      facebookPassword: json['facebookPassword'],
      instagramEmail: json['instagramEmail'],
      instagramPassword: json['instagramPassword'],
      linkedInEmail: json['linkedInEmail'],
      linkedInPassword: json['linkedInPassword']
    );
  }

  factory GDSCCampus.fromDoc(DocumentSnapshot GDSCCampusDoc)
  {
    final GDSCCampusData = GDSCCampusDoc.data() as Map<String, dynamic>?;
    return GDSCCampus
    (
      id: GDSCCampusData!['id'],
      name: GDSCCampusData!['name'], 
      email: GDSCCampusData!['email'], 
      location: GDSCCampusData!['location'],
      lead: GDSCCampusData!['lead'], 
      facebookEmail: GDSCCampusData!['facebookEmail'],
      facebookPassword: GDSCCampusData!['facebookPassword'],
      instagramEmail: GDSCCampusData!['instagramEmail'],
      instagramPassword: GDSCCampusData!['instagramPassword'],
      linkedInEmail: GDSCCampusData!['linkedInEmail'],
      linkedInPassword: GDSCCampusData!['linkedInPassword']
    );
  }

  factory GDSCCampus.initial()
  {
    return const GDSCCampus
    (
      id: '',
      name: '', 
      email: '',
      location: '',
      lead: '',
      facebookEmail: '',
      facebookPassword: '',
      instagramEmail: '',
      instagramPassword: '',
      linkedInEmail: '',
      linkedInPassword: ''

    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    return [id, name, email, location, lead, facebookEmail, facebookPassword, instagramEmail, instagramPassword, linkedInEmail, linkedInPassword];
  }
  
  GDSCCampus copyWith
  (
    {
      String? id,
      String? name,
      String? email,
      String? location,
      String? lead,
      String? facebookEmail,
      String? facebookPassword,
      String? instagramEmail,
      String? instagramPassword,
      String? linkedInEmail,
      String? linkedInPassword
    }
  )
  {
    return GDSCCampus
    (
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      lead: lead ?? this.lead,
      facebookEmail: facebookEmail ?? this.facebookEmail,
      facebookPassword: facebookPassword ?? this.facebookPassword,
      instagramEmail: instagramEmail ?? this.instagramEmail,
      instagramPassword: instagramPassword ?? this.instagramPassword,
      linkedInEmail: linkedInEmail ?? this.linkedInEmail,
      linkedInPassword: linkedInPassword ?? this.linkedInPassword
    );
  }

  static GDSCCampus fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return GDSCCampus
    (
      id: snapshot['id'],
      name: snapshot['name'], 
      email: snapshot['email'], 
      location: snapshot['location'],
      lead: snapshot['lead'], 
      facebookEmail: snapshot['facebookEmail'],
      facebookPassword: snapshot['facebookPassword'],
      instagramEmail: snapshot['instagramEmail'],
      instagramPassword: snapshot['instagramPassword'],
      linkedInEmail: snapshot['linkedInEmail'],
      linkedInPassword: snapshot['linkedInPassword']
    );
  }
}
