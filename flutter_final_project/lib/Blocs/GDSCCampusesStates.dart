import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';

abstract class GDSCCampusesState extends Equatable
{
  const GDSCCampusesState();
  List<Object> get props => [];
}

class GDSCCampusesEmptyState extends GDSCCampusesState
{
  //Ye empty rahay ga
}

class GDSCCampusesInitialState extends GDSCCampusesState
{
  //Ye bhi empty rahay ga
}

class GDSCCampusesLoadingState extends GDSCCampusesState
{
  @override
  List<Object> get props => [];
}

class GDSCCampusesSuccessOrLoadedState extends GDSCCampusesState
{
  final Stream<List<GDSCCampus>> campus;
  GDSCCampusesSuccessOrLoadedState(this.campus);

  @override
  List<Object> get props => [campus];
}

class GDSCCampusesErrorState extends GDSCCampusesState
{
  final String error;
  const GDSCCampusesErrorState(this.error);

  @override
  List<Object> get props => [error];
}