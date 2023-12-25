import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable
{
  final String id;
  final String name;
  final String email;
  final String role; //admin, GDSC member, GDSC lead
  final String? campus;
  final bool? approved;

  const User
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

  static User fromJson(Map<String, dynamic> json) 
  {
    return User
    (
      id: json['id'],
      name: json['name'], 
      email: json['email'], 
      role: json['role'],
      campus: json['campus'], 
      approved: json['approved']
    );
  }

  factory User.fromDoc(DocumentSnapshot userDoc)
  {
    final userData = userDoc.data() as Map<String, dynamic>?;
    return User
    (
      id: userData!['id'],
      name: userData!['name'], 
      email: userData!['email'], 
      role: userData!['role'],
      campus: userData!['campus'], 
      approved: userData!['approved']
    );
  }

  factory User.initial()
  {
    return const User
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
  
  User copyWith
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
    return User
    (
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      campus: campus ?? this.campus,
      approved: approved ?? this.approved
    );
  }
  
}
