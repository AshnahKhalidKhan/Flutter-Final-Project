import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/events_list/EventsListEvents.dart';
import 'package:flutter_final_project/blocs/events_list/EventsListStates.dart';
import 'package:flutter_final_project/core/repositories/EventsListRepository.dart';
import 'package:flutter_final_project/models/event_model.dart';

class EventsListBloc extends Bloc<EventsListEvent, EventsListState> {
  final EventsListRepository eventListRepository;
  StreamSubscription<List<Event>>? eventListStreamSubscription;

  EventsListBloc({required this.eventListRepository})
      : super(EventsListInitialState()) {
    @override
    Future<void> close() async {
      await eventListStreamSubscription!.cancel();
      return super.close();
    }

    on<EventsListEvent>((event, emit) {});

    on<CreateEventEvent>((event, emit) async {
      try {
        if (state is EventsListSuccessOrLoadedState) {
          await eventListRepository.createEventFunctionInEventRepositoryFile(
              campusId: event.campusId,
              eventName: event.eventName,
              date: event.date,
              startTime: event.startTime,
              endTime: event.endTime,
              location: event.location);
        }
      } catch (e) {
        emit(const EventsListErrorState('Event creation failed.'));
      }
    });

    on<ReadEventEvent>((event, emit) {
      try {
        emit(EventsListLoadingState());
        Stream<List<Event>> streamResponse = eventListRepository
            .readEventFunctionInEventRepositoryFile(event.campusId);
        emit(EventsListSuccessOrLoadedState(streamResponse));
      } catch (e) {
        emit(const EventsListErrorState('Event loading/reading failed.'));
      }
    });

    // on<ReadAllEventsOfOneCampusUsingUserIdLoadedEvent>((event, emit)
    // {
    //   try
    //   {
    //     emit(EventsListLoadingState());
    //     Future<Stream<List<Event>>> streamResponse = eventListRepository.readAllEventsOfOneCampusUsingUserIdOfMemberFunctionInRepositoryFile(event.userId);
    //     // print(streamResponse.toString());
    //     emit(AllEventsOfOneCampusUsingUserIdLoadedState(streamResponse));
    //   }
    //   catch(e)
    //   {
    //     emit(const EventsListErrorState('Event loading/reading failed.'));
    //   }
    // });

    on<ReadAllEventsOfOneCampusUsingUserIdLoadedEvent>((event, emit) {
      try {
        emit(EventsListLoadingState());
        Stream<List<Event>> streamResponse = eventListRepository
            .readEventFunctionInEventRepositoryFile(event.userId);
        // print(streamResponse.toString());
        emit(AllEventsOfOneCampusUsingUserIdLoadedState(streamResponse));
      } catch (e) {
        emit(const EventsListErrorState('Event loading/reading failed.'));
      }
    });

    on<ReadOneEventEvent>((event, emit) async {
      try {
        emit(EventsListLoadingState());
        final Event? eventInstance = await eventListRepository.readOneEventFunctionInEventRepositoryFile
        (
          event.eventId
        );
        emit(OneEventSuccessOrLoadedState(eventInstance!));
      } catch (e) {
        emit(const EventsListErrorState('OneEvent loading/reading failed.'));
      }
    });

    // on<ReadAllEventsListEvent>((event, emit)
    // {
    //   try
    //   {
    //     emit(EventsListLoadingState());
    //     Stream<List<Event>> streamResponse = eventListRepository.allEventsListFunctionInEventsListRepositoryFile();
    //     emit(EventsListSuccessOrLoadedState(streamResponse));
    //   }
    //   catch(e)
    //   {
    //     emit(const EventsListErrorState('Event loading/reading failed.'));
    //   }
    // });

    on<UpdateEventEvent>((event, emit) async {
      try {
        if (state is EventsListSuccessOrLoadedState) {
          await eventListRepository
              .updateEventFunctionInEventRepositoryFile(event.event);
        }
      } catch (e) {
        emit(const EventsListErrorState('Event update-ion failed.'));
      }
    });

    on<DeleteEventEvent>((event, emit) async {
      try {
        if (state is EventsListSuccessOrLoadedState) {
          await eventListRepository
              .deleteEventFunctionInEventRepositoryFile(event.eventId);
        }
      } catch (e) {
        emit(const EventsListErrorState('Event deletion failed.'));
      }
    });
  }
}
