import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/DiscussionsEvents.dart';
import 'package:flutter_final_project/Blocs/DiscussionsStates.dart';
import 'package:flutter_final_project/Core/Repositories/DiscussionsRepository.dart';
import 'package:flutter_final_project/Models/DiscussionsModel.dart';

class DiscussionsBloc extends Bloc<DiscussionsEvent, DiscussionsState> 
{
  final DiscussionsRepository discussionsRepository;
  
  DiscussionsBloc({required this.discussionsRepository}) : super(DiscussionsInitialState()) 
  {
    StreamSubscription<List<Discussion>>? discussionsStreamSubscription;

    @override
    Future<void> close() async 
    {
      await discussionsStreamSubscription!.cancel();
      return super.close();
    }

    on<DiscussionsEvent>((event, emit) {});

    on<CreateDiscussionEvent>((event, emit) async 
    {
      try 
      {
        if (state is DiscussionsSuccessOrLoadedState)
        {
          await discussionsRepository.createDiscussionFunctionInDiscussionRepositoryFile
          (
            eventId: event.eventId,
            timestamp: event.timestamp, 
            senderId: event.senderId, 
            message: event.message
          );
        }
      } 
      catch (e) 
      {
        emit(const DiscussionsErrorState('Discussion creation failed.'));
      }
    });
    ///////////////////////////////////

        on<ReadDiscussionEvent>((event, emit) {
          try {
            emit(DiscussionsLoadingState());
            final streamResponse = discussionsRepository.readDiscussionFunctionInDiscussionRepositoryFile(event.eventId);
            discussionsStreamSubscription?.cancel();
            discussionsStreamSubscription = streamResponse.listen((discussion) 
            {
              add(ReadDiscussionEvent(event.eventId));
              emit(DiscussionsSuccessOrLoadedState(discussion));
              // add(DiscussionsSuccessOrLoadedState(discussion));
            });
            // emit(DiscussionsSuccessOrLoadedState(disc));
          } 
          catch(e) 
          {
            emit(const DiscussionsErrorState('Discussion loading/reading failed.'));
          }
        });

        // on<LoadDataEvent>((event, emit) {
        //   try{
        //     emit(FirebaseCrudLoaded(event.users));
        //   }catch(_){
        //     emit(FirebaseCrudFailure());
        //   }
        // });


    /////////////////////////////
    on<UpdateDiscussionEvent>((event, emit) async 
    {
      try 
      {
        if (state is DiscussionsSuccessOrLoadedState)
        {
          await discussionsRepository.updateDiscussionFunctionInDiscussionRepositoryFile(event.discussion);
        }
      } 
      catch (e) 
      {
        emit(const DiscussionsErrorState('Discussion update-ion failed.'));
      }
    });

    on<DeleteDiscussionEvent>((event, emit) async 
    {
      try 
      {
        if (state is DiscussionsSuccessOrLoadedState)
        {
          await discussionsRepository.deleteDiscussionFunctionInDiscussionRepositoryFile(event.discussionId);
        }
      } 
      catch (e) 
      {
        emit(const DiscussionsErrorState('Discussion deletion failed.'));
      }
    });
  }
}

// class DiscussionsBloc extends Bloc<DiscussionsEvent, DiscussionsState> 
// {
//   final DiscussionsRepository discussionsRepository;

//   DiscussionsBloc({required this.discussionsRepository}) : super(DiscussionsEmptyState());

//   @override
//   Stream<DiscussionsState> mapEventToState(DiscussionsEvent event) async* 
//   {
//     if (event is CreateDiscussionEvent) 
//     {
//       yield* mapCreateDiscussionToState(event);
//     }
//     else if (event is ReadDiscussionEvent) 
//     {
//       yield* mapReadDiscussionToState(event);
//     } 
//     else if (event is UpdateDiscussionEvent) 
//     {
//       yield* mapUpdateDiscussionToState(event);
//     } 
//     else if (event is DeleteDiscussionEvent) 
//     {
//       yield* mapDeleteDiscussionToState(event);
//     }
//   }

//   Stream<DiscussionsState> mapCreateDiscussionToState (CreateDiscussionEvent event) async* 
//   {
//     try 
//     {
//       await discussionsRepository.createDiscussionFunctionInDiscussionRepositoryFile
//       (
//         eventId: event.eventId,
//         timestamp: event.timestamp,
//         senderId: event.senderId,
//         message: event.message,
//       );
//     } 
//     catch (e) 
//     {
//       yield DiscussionsErrorState('Discussion creation failed.');
//     }
//   }

//   Stream<DiscussionsState> mapReadDiscussionToState(ReadDiscussionEvent event) async* 
//   {
//     try 
//     {
//       yield DiscussionsLoadingState();
//       final discussions = discussionsRepository.readDiscussionFunctionInDiscussionRepositoryFile(event.eventId);
//       await for (var discussion in discussions) 
//       {
//         yield DiscussionsSuccessOrLoadedState(discussion as Discussion);
//       }
//     } 
//     catch (e) 
//     {
//       yield DiscussionsErrorState('Error reading discussions.');
//     }
//   }

//   Stream<DiscussionsState> mapUpdateDiscussionToState (UpdateDiscussionEvent event) async* 
//   {
//     try 
//     {
//       await discussionsRepository.updateDiscussionFunctionInDiscussionRepositoryFile(event.discussion);
//       yield DiscussionsSuccessOrLoadedState(event.discussion);
//     } 
//     catch (e) 
//     {
//       yield DiscussionsErrorState('Discussion update failed.');
//     }
//   }

//   Stream<DiscussionsState> mapDeleteDiscussionToState (DeleteDiscussionEvent event) async* 
//   {
//     try 
//     {
//       await discussionsRepository.deleteDiscussionFunctionInDiscussionRepositoryFile(event.discussionId);
//       yield DiscussionsEmptyState();
//     } 
//     catch (e) 
//     {
//       yield DiscussionsErrorState('Discussion deletion failed.');
//     }
//   }
// }
