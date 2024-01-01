import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/event_model.dart';

abstract class EventsListEvent extends Equatable
{
  const EventsListEvent();
  List<Object> get props => [];
}

class CreateEventEvent extends EventsListEvent 
{
  final String campusId;
  final String eventName;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  
  const CreateEventEvent(this.campusId, this.eventName, this.date, this.startTime, this.endTime, this.location);

  @override
  List<Object> get props => [eventName, date, location];
}

class ReadEventEvent extends EventsListEvent 
{
  final String campusId;

  const ReadEventEvent(this.campusId);

  @override
  List<Object> get props => [campusId];
}

class ReadOneEventEvent extends EventsListEvent 
{
  final String eventId;

  const ReadOneEventEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

// class ReadAllEventsListEvent extends EventsListEvent 
// {
//   const ReadAllEventsListEvent();
//   @override
//   List<Object> get props => [];
// }

class UpdateEventEvent extends EventsListEvent
{
  final Event event;

  const UpdateEventEvent(this.event);
  
  @override
  List<Object> get props => [event];
}

class DeleteEventEvent extends EventsListEvent
{
  final String eventId;

  const DeleteEventEvent(this.eventId);
  
  @override
  List<Object> get props => [eventId];
}





class ReadAllEventsOfOneCampusUsingUserIdLoadedEvent extends EventsListEvent 
{
  final String userId;

  const ReadAllEventsOfOneCampusUsingUserIdLoadedEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

// class AllEventsOfOneCampusUsingUserIdLoadedEvent extends EventsListEvent 
// {
//   const AllEventsOfOneCampusUsingUserIdLoadedEvent();
//   @override
//   List<Object> get props => [];
// }