import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/UserModel.dart';

abstract class GDSCLeadsMembersListState extends Equatable
{
  const GDSCLeadsMembersListState();
  List<Object> get props => [];
}

class GDSCLeadsMembersListEmptyState extends GDSCLeadsMembersListState
{
  //Ye empty rahay ga
}

class GDSCLeadsMembersListInitialState extends GDSCLeadsMembersListState
{
  //Ye bhi empty rahay ga
}

class GDSCLeadsMembersListLoadingState extends GDSCLeadsMembersListState
{
  @override
  List<Object> get props => [];
}

class GDSCLeadsMembersListSuccessOrLoadedState extends GDSCLeadsMembersListState
{
  final Stream<List<AppUser>> user;
  GDSCLeadsMembersListSuccessOrLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class OneGDSCLeadsMembersListSuccessOrLoadedState extends GDSCLeadsMembersListState
{
  final Future<AppUser?> user;
  OneGDSCLeadsMembersListSuccessOrLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class GDSCLeadsMembersListErrorState extends GDSCLeadsMembersListState
{
  final String error;
  const GDSCLeadsMembersListErrorState(this.error);

  @override
  List<Object> get props => [error];
}