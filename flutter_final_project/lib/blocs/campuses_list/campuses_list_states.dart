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

class AppUserAddedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AppUserUpdatedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AppUserDeletedState extends AdminsState
{
  @override
  List<Object> get props => [];
}

class AdminsLoadedState extends AdminsState
{
  final Stream<List<AppUser>> campus;
  AdminsLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class OneAppUserLoadedState extends AdminsState
{
  final AppUser campus;
  OneAppUserLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class AdminsErrorState extends AdminsState
{
  final String error;
  const AdminsErrorState(this.error);

  @override
  List<Object> get props => [error];
}