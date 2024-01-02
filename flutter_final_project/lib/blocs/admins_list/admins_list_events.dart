import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/user_model.dart';

abstract class AdminsEvent extends Equatable
{
  const AdminsEvent();
  List<Object> get props => [];
}

class CreateAdminEvent extends AdminsEvent 
{
  final String name;
  final String email;
  final String role;
  
  const CreateAdminEvent(this.name, this.email, this.role);

  @override
  List<Object> get props => [name, email, role];
}

class ReadOneAdminEvent extends AdminsEvent 
{
  final String userId;

  const ReadOneAdminEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class ReadAllAdminsEvent extends AdminsEvent 
{
  const ReadAllAdminsEvent();
  @override
  List<Object> get props => [];
}

class UpdateAdminEvent extends AdminsEvent
{
  final AppUser user;

  const UpdateAdminEvent(this.user);
  
  @override
  List<Object> get props => [user];
}

class DeleteAdminEvent extends AdminsEvent
{
  final String userId;

  const DeleteAdminEvent(this.userId);
  
  @override
  List<Object> get props => [userId];
}