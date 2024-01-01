import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/blocs/campuses_list/GDSCCampusesStates.dart';
import 'package:flutter_final_project/core/repositories/GDSCCampusesRepository.dart';
import 'package:flutter_final_project/models/GDSCCampusModel.dart';

class GDSCCampusesBloc extends Bloc<GDSCCampusesEvent, GDSCCampusesState> 
{
  final GDSCCampusesRepository campussRepository;
  StreamSubscription<List<GDSCCampus>>? campussStreamSubscription;
  
  GDSCCampusesBloc({required this.campussRepository}) : super(GDSCCampusesInitialState()) 
  {
    @override
    Future<void> close() async 
    {
      await campussStreamSubscription!.cancel();
      return super.close();
    }

    on<GDSCCampusesEvent>((event, emit) {});

    on<CreateGDSCCampusEvent>((event, emit) async 
    {
      try 
      {
        // emit(GDSCCampusesLoadingState());
        // await campussRepository.createGDSCCampusFunctionInGDSCCampusesRepositoryFile
        // (
        //   campusName: event.campusName, 
        //   email: event.email, 
        //   location: event.location
        // );
        // emit(GDSCCampusesInitialState());
        // Stream<List<GDSCCampus>> streamResponse = campussRepository.allGDSCCampusesFunctionInGDSCCampusesRepositoryFile();
        // emit(GDSCCampusesSuccessOrLoadedState(streamResponse));
        if (state is GDSCCampusesSuccessOrLoadedState)
        {
          await campussRepository.createGDSCCampusFunctionInGDSCCampusesRepositoryFile
          (
            campusName: event.campusName, 
            email: event.email, 
            location: event.location
          );
        }
      } 
      catch (e) 
      {
        emit(const GDSCCampusesErrorState('GDSCCampus creation failed.'));
      }
    });
    ///////////////////////////////////

    on<ReadGDSCCampusEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCCampusesLoadingState());
        final streamResponse = campussRepository.readGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campusId);
        campussStreamSubscription?.cancel();
        campussStreamSubscription = streamResponse.listen((campus) 
        {
          add(ReadGDSCCampusEvent(event.campusId));
          // emit(GDSCCampusesSuccessOrLoadedState(campus));
          // add(GDSCCampusesSuccessOrLoadedState(campus));
        });
        // emit(GDSCCampusesSuccessOrLoadedState(disc));
      } 
      catch(e) 
      {
        emit(const GDSCCampusesErrorState('GDSCCampus loading/reading failed.'));
      }
    });

    on<ReadOneGDSCCampusEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCCampusesLoadingState());
        final campus = campussRepository.readOneGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campusId);
        emit(OneGDSCCampusSuccessOrLoadedState(campus));
      } 
      catch(e) 
      {
        emit(const GDSCCampusesErrorState('OneGDSCCampus loading/reading failed.'));
      }
    });

    on<ReadAllGDSCCampusesEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCCampusesLoadingState());
        Stream<List<GDSCCampus>> streamResponse = campussRepository.allGDSCCampusesFunctionInGDSCCampusesRepositoryFile();
        emit(GDSCCampusesSuccessOrLoadedState(streamResponse));
        // campussStreamSubscription?.cancel();
        // emit(GDSCCampusesSuccessOrLoadedState(str));
        // campussStreamSubscription = streamResponse.listen((campus) 
        // {
        //   // add(ReadAllGDSCCampusesEvent());
        //   emit(GDSCCampusesSuccessOrLoadedState(streamResponse));
        //   // add(GDSCCampusesSuccessOrLoadedState(campus));
        // });
        // emit(GDSCCampusesSuccessOrLoadedState());
      } 
      catch(e) 
      {
        emit(const GDSCCampusesErrorState('GDSCCampus loading/reading failed.'));
      }
    });
    ////////////////////////////////////////////

    on<UpdateGDSCCampusEvent>((event, emit) async 
    {
      try 
      {
        // emit(GDSCCampusesLoadingState());
        // print('************************************');
        // await campussRepository.updateGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campus);
        if (state is GDSCCampusesSuccessOrLoadedState)
        {
          // print('\n\n\n\n\n**************************************************************');
          await campussRepository.updateGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campus);
        }
      } 
      catch (e) 
      {
        emit(const GDSCCampusesErrorState('GDSCCampus update-ion failed.'));
      }
    });

    on<DeleteGDSCCampusEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCCampusesSuccessOrLoadedState)
        {
          await campussRepository.deleteGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campusId);
        }
      } 
      catch (e) 
      {
        emit(const GDSCCampusesErrorState('GDSCCampus deletion failed.'));
      }
    });
  }
}

// class GDSCCampusesBloc extends Bloc<GDSCCampusesEvent, GDSCCampusesState> 
// {
//   final GDSCCampusesRepository campussRepository;

//   GDSCCampusesBloc({required this.campussRepository}) : super(GDSCCampusesEmptyState());

//   @override
//   Stream<GDSCCampusesState> mapEventToState(GDSCCampusesEvent event) async* 
//   {
//     if (event is CreateGDSCCampusEvent) 
//     {
//       yield* mapCreateGDSCCampusToState(event);
//     }
//     else if (event is ReadAllGDSCCampusesEvent) 
//     {
//       yield* mapReadGDSCCampusToState(event);
//     } 
//     else if (event is UpdateGDSCCampusEvent) 
//     {
//       yield* mapUpdateGDSCCampusToState(event);
//     } 
//     else if (event is DeleteGDSCCampusEvent) 
//     {
//       yield* mapDeleteGDSCCampusToState(event);
//     }
//   }

//   Stream<GDSCCampusesState> mapCreateGDSCCampusToState (CreateGDSCCampusEvent event) async* 
//   {
//     try 
//     {
//       await campussRepository.createGDSCCampusFunctionInGDSCCampusesRepositoryFile
//       (
//         campusId: event.campusId,
//         campusName: event.campusName,
//         email: event.email,
//         location: event.location,
//       );
//     } 
//     catch (e) 
//     {
//       yield GDSCCampusesErrorState('GDSCCampus creation failed.');
//     }
//   }

//   Stream<GDSCCampusesState> mapReadGDSCCampusToState(ReadAllGDSCCampusesEvent event) async* 
//   {
//     try 
//     {
//       yield GDSCCampusesLoadingState();
//       final campuss = campussRepository.allGDSCCampusesFunctionInGDSCCampusesRepositoryFile();
//       await for (var campus in campuss) 
//       {
//         yield GDSCCampusesSuccessOrLoadedState(campus as Stream<List<GDSCCampus>>);
//       }
//     } 
//     catch (e) 
//     {
//       yield GDSCCampusesErrorState('Error reading campuss.');
//     }
//   }

//   Stream<GDSCCampusesState> mapUpdateGDSCCampusToState (UpdateGDSCCampusEvent event) async* 
//   {
//     try 
//     {
//       await campussRepository.updateGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campus);
//       yield GDSCCampusesSuccessOrLoadedState(event.campus as Stream<List<GDSCCampus>>);
//     } 
//     catch (e) 
//     {
//       yield GDSCCampusesErrorState('GDSCCampus update failed.');
//     }
//   }

//   Stream<GDSCCampusesState> mapDeleteGDSCCampusToState (DeleteGDSCCampusEvent event) async* 
//   {
//     try 
//     {
//       await campussRepository.deleteGDSCCampusFunctionInGDSCCampusesRepositoryFile(event.campusId);
//       yield GDSCCampusesEmptyState();
//     } 
//     catch (e) 
//     {
//       yield GDSCCampusesErrorState('GDSCCampus deletion failed.');
//     }
//   }
// }
