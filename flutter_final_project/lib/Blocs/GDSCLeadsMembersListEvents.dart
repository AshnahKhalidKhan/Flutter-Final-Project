import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

abstract class GDSCLeadsMembersListEvent extends Equatable
{
  const GDSCLeadsMembersListEvent();
  List<Object> get props => [];
}

class CreateGDSCLeadsMembersListEvent extends GDSCLeadsMembersListEvent 
{
  final String name;
  final String email;
  final String role;
  
  const CreateGDSCLeadsMembersListEvent(this.name, this.email, this.role);

  @override
  List<Object> get props => [name, email, role];
}

class ReadGDSCLeadsMembersListEvent extends GDSCLeadsMembersListEvent 
{
  final String userId;

  const ReadGDSCLeadsMembersListEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class ReadAllGDSCLeadsMembersListEvent extends GDSCLeadsMembersListEvent 
{
  const ReadAllGDSCLeadsMembersListEvent();
  @override
  List<Object> get props => [];
}

class ReadAllAdminsListEvent extends GDSCLeadsMembersListEvent 
{
  const ReadAllAdminsListEvent();
  @override
  List<Object> get props => [];
}

class ReadAllApprovedGDSCLeadsListEvent extends GDSCLeadsMembersListEvent 
{
  const ReadAllApprovedGDSCLeadsListEvent();
  @override
  List<Object> get props => [];
}

class ReadAllPendingGDSCLeadsListEvent extends GDSCLeadsMembersListEvent 
{
  const ReadAllPendingGDSCLeadsListEvent();
  @override
  List<Object> get props => [];
}

class ApproveGDSCLeadEvent extends GDSCLeadsMembersListEvent
{
  final AppUser user;

  const ApproveGDSCLeadEvent(this.user);
  
  @override
  List<Object> get props => [user];
}

class RemoveGDSCLeadEvent extends GDSCLeadsMembersListEvent
{
  final AppUser user;

  const RemoveGDSCLeadEvent(this.user);
  
  @override
  List<Object> get props => [user];
}

class UpdateGDSCLeadsMembersListEvent extends GDSCLeadsMembersListEvent
{
  final AppUser user;

  const UpdateGDSCLeadsMembersListEvent(this.user);
  
  @override
  List<Object> get props => [user];
}

class DeleteGDSCLeadsMembersListEvent extends GDSCLeadsMembersListEvent
{
  final String userId;

  const DeleteGDSCLeadsMembersListEvent(this.userId);
  
  @override
  List<Object> get props => [userId];
}