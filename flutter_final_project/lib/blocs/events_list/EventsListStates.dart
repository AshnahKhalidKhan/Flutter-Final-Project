import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/event_model.dart';

abstract class EventsListState extends Equatable
{
  const EventsListState();
  List<Object> get props => [];
}

class EventsListEmptyState extends EventsListState
{
  //Ye empty rahay ga
}

class EventsListInitialState extends EventsListState
{
  //Ye bhi empty rahay ga
}

class EventsListLoadingState extends EventsListState
{
  @override
  List<Object> get props => [];
}

class EventsListSuccessOrLoadedState extends EventsListState
{
  final Stream<List<Event>> event;
  EventsListSuccessOrLoadedState(this.event);

  @override
  List<Object> get props => [event];
}

class OneEventSuccessOrLoadedState extends EventsListState
{
  final Event event;
  OneEventSuccessOrLoadedState(this.event);

  @override
  List<Object> get props => [event];
}

class EventsListErrorState extends EventsListState
{
  final String error;
  const EventsListErrorState(this.error);

  @override
  List<Object> get props => [error];
}




class AllEventsOfOneCampusUsingUserIdLoadedState extends EventsListState
{
  final Stream<List<Event>> event;
  const AllEventsOfOneCampusUsingUserIdLoadedState(this.event);

  @override
  List<Object> get props => [event];
}