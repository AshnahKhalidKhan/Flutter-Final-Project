import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/user_model.dart';

abstract class AdminsState extends Equatable
{
  const AdminsState();
  List<Object> get props => [];
}

class AdminsInitialState extends AdminsState
{
  //Ye bhi empty rahay ga
}

class AdminsLoadingState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminsSuccessState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminAddedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminUpdatedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminDeletedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminsLoadedState extends AdminsState
{
  final Stream<List<AppUser>> user;
  AdminsLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class OneAdminLoadedState extends AdminsState
{
  // Future<AppUser?>
  final AppUser user;
  OneAdminLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class AdminsErrorState extends AdminsState
{
  final String error;
  const AdminsErrorState(this.error);

  @override
  List<Object> get props => [error];
}