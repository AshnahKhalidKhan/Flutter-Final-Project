import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/campus_model.dart';

abstract class CampusesState extends Equatable
{
  const CampusesState();
  List<Object> get props => [];
}

class CampusesInitialState extends CampusesState
{
  //Ye bhi empty rahay ga
}

class CampusesLoadingState extends CampusesState
{
  @override
  List<Object> get props => [];
}

class CampusesSuccessState extends CampusesState
{
  @override
  List<Object> get props => [];
}

class CampusAddedState extends CampusesState
{
  @override
  List<Object> get props => [];
}

class CampusUpdatedState extends CampusesState
{
  @override
  List<Object> get props => [];
}

class CampusDeletedState extends CampusesState
{
  @override
  List<Object> get props => [];
}

class CampusesLoadedState extends CampusesState
{
  final Stream<List<Campus>> campus;
  CampusesLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class OneCampusLoadedState extends CampusesState
{
  final Campus campus;
  OneCampusLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class CampusesErrorState extends CampusesState
{
  final String error;
  const CampusesErrorState(this.error);

  @override
  List<Object> get props => [error];
}