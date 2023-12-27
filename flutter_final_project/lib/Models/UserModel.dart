import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable
{
  final String id;
  final String name;
  final String email;
  final String role; //admin, GDSC member, GDSC lead
  final String? campus;
  final bool? approved;

  const AppUser
  (
    {
      required this.id,
      required this.name,
      required this.email,
      required this.role,
      this.campus,
      required this.approved
    }
  );

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'name': name, 
    'email': email,
    'role': role,
    'campus': campus,
    'approved': approved
  };

  static AppUser fromJson(Map<String, dynamic> json) 
  {
    return AppUser
    (
      id: json['id'],
      name: json['name'], 
      email: json['email'], 
      role: json['role'],
      campus: json['campus'], 
      approved: json['approved']
    );
  }

  factory AppUser.fromDoc(DocumentSnapshot AppUserDoc)
  {
    final AppUserData = AppUserDoc.data() as Map<String, dynamic>?;
    return AppUser
    (
      id: AppUserData!['id'],
      name: AppUserData!['name'], 
      email: AppUserData!['email'], 
      role: AppUserData!['role'],
      campus: AppUserData!['campus'], 
      approved: AppUserData!['approved']
    );
  }

  factory AppUser.initial()
  {
    return const AppUser
    (
      id: '',
      name: '', 
      email: '',
      role: '',
      campus: '',
      approved: false
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props 
  {
    return [id, name, email, role, campus, approved];
  }
  
  AppUser copyWith
  (
    {
      String? id,
      String? name,
      String? email,
      String? role,
      String? campus,
      bool? approved
    }
  )
  {
    return AppUser
    (
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      campus: campus ?? this.campus,
      approved: approved ?? this.approved
    );
  }

  static AppUser fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return AppUser
    (
      id: snapshot['id'],
      name: snapshot['name'], 
      email: snapshot['email'], 
      role: snapshot['role'],
      campus: snapshot['campus'], 
      approved: snapshot['approved']
    );
  }
}
