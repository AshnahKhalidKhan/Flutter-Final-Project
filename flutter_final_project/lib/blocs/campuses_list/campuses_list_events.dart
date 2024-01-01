import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/campus_model.dart';

abstract class CampusesEvent extends Equatable
{
  const CampusesEvent();
  List<Object> get props => [];
}

class CreateCampusEvent extends CampusesEvent 
{
  final String campusName;
  final String email;
  final String location;
  
  const CreateCampusEvent(this.campusName, this.email, this.location);

  @override
  List<Object> get props => [campusName, email, location];
}

class ReadCampusEvent extends CampusesEvent 
{
  final String campusId;

  const ReadCampusEvent(this.campusId);

  @override
  List<Object> get props => [campusId];
}

class ReadOneCampusEvent extends CampusesEvent 
{
  final String campusId;

  const ReadOneCampusEvent(this.campusId);

  @override
  List<Object> get props => [campusId];
}

class ReadAllCampusesEvent extends CampusesEvent 
{
  const ReadAllCampusesEvent();
  @override
  List<Object> get props => [];
}

class UpdateCampusEvent extends CampusesEvent
{
  final Campus campus;

  const UpdateCampusEvent(this.campus);
  
  @override
  List<Object> get props => [campus];
}

class DeleteCampusEvent extends CampusesEvent
{
  final String campusId;

  const DeleteCampusEvent(this.campusId);
  
  @override
  List<Object> get props => [campusId];
}