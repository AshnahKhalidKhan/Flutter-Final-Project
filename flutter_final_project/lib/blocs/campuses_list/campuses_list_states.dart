import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/campus_model.dart';

abstract class CampusesState extends Equatable
{
  const CampusesState();
  List<Object> get props => [];
}

class CampusesEmptyState extends CampusesState
{
  //Ye empty rahay ga
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

class CampusesSuccessOrLoadedState extends CampusesState
{
  final Stream<List<Campus>> campus;
  CampusesSuccessOrLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class OneCampusSuccessOrLoadedState extends CampusesState
{
  final Future<Campus?> campus;
  OneCampusSuccessOrLoadedState(this.campus);

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