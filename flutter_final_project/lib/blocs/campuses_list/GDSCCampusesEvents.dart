import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/GDSCCampusModel.dart';

abstract class GDSCCampusesEvent extends Equatable
{
  const GDSCCampusesEvent();
  List<Object> get props => [];
}

class CreateGDSCCampusEvent extends GDSCCampusesEvent 
{
  final String campusName;
  final String email;
  final String location;
  
  const CreateGDSCCampusEvent(this.campusName, this.email, this.location);

  @override
  List<Object> get props => [campusName, email, location];
}

class ReadGDSCCampusEvent extends GDSCCampusesEvent 
{
  final String campusId;

  const ReadGDSCCampusEvent(this.campusId);

  @override
  List<Object> get props => [campusId];
}

class ReadOneGDSCCampusEvent extends GDSCCampusesEvent 
{
  final String campusId;

  const ReadOneGDSCCampusEvent(this.campusId);

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