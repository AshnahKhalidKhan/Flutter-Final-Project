import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';

abstract class GDSCCampusesEvent extends Equatable
{
  const GDSCCampusesEvent();
  List<Object> get props => [];
}

class CreateGDSCCampusEvent extends GDSCCampusesEvent 
{
  final String campusId;
  final String campusName;
  final String email;
  final String location;
  final String lead;
  
  const CreateGDSCCampusEvent(this.campusId, this.campusName, this.email, this.location, this.lead);

  @override
  List<Object> get props => [campusId, campusName, email, location, this.lead];
}

class ReadGDSCCampusEvent extends GDSCCampusesEvent 
{
  final String campusId;

  const ReadGDSCCampusEvent(this.campusId);

  @override
  List<Object> get props => [campusId];
}

class ReadAllGDSCCampusesEvent extends GDSCCampusesEvent 
{
  const ReadAllGDSCCampusesEvent();
  @override
  List<Object> get props => [];
}

class UpdateGDSCCampusEvent extends GDSCCampusesEvent
{
  final GDSCCampus campus;

  const UpdateGDSCCampusEvent(this.campus);
  
  @override
  List<Object> get props => [campus];
}

class DeleteGDSCCampusEvent extends GDSCCampusesEvent
{
  final String campusId;

  const DeleteGDSCCampusEvent(this.campusId);
  
  @override
  List<Object> get props => [campusId];
}