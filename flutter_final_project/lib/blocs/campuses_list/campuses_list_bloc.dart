import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/campuses_list_events.dart';
import 'package:flutter_final_project/blocs/campuses_list/campuses_list_states.dart';
import 'package:flutter_final_project/core/repositories/campus_repository.dart';
import 'package:flutter_final_project/models/campus_model.dart';

class CampusesBloc extends Bloc<CampusesEvent, CampusesState> 
{
  final CampusesRepository campussRepository;
  
  CampusesBloc({required this.campussRepository}) : super(CampusesInitialState()) 
  {
    on<CreateCampusEvent>((event, emit) async 
    {
      emit(CampusesLoadingState());
      try 
      {
        await campussRepository.createCampusFunctionInCampusesRepositoryFile
        (
          campusName: event.campusName, 
          email: event.email, 
          location: event.location
        );
        emit(CampusesSuccessState());
      } 
      catch (e) 
      {
        emit(CampusesErrorState(e.toString()));
      }
    });

    on<ReadOneCampusEvent>((event, emit) async
    {
      emit(CampusesLoadingState());
      try 
      {
        final Campus? campus = await campussRepository.readOneCampusFunctionInCampusesRepositoryFile(event.campusId);
        emit(OneCampusLoadedState(campus!));
      } 
      catch(e) 
      {
        emit(CampusesErrorState(e.toString()));
      }
    });

    on<ReadAllCampusesEvent>((event, emit) 
    {
      emit(CampusesLoadingState());
      try 
      {
        Stream<List<Campus>> streamResponse = campussRepository.readAllCampusesFunctionInCampusesRepositoryFile();
        emit(CampusesLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(CampusesErrorState(e.toString()));
      }
    });

    on<UpdateCampusEvent>((event, emit) async 
    {
      try 
      {
        if (state is CampusesLoadedState)
        {
          await campussRepository.updateCampusFunctionInCampusesRepositoryFile(event.campus);
        }
      } 
      catch (e) 
      {
        emit(CampusesErrorState(e.toString()));
      }
    });

    on<DeleteCampusEvent>((event, emit) async 
    {
      emit(CampusesLoadingState());
      try 
      {
        await campussRepository.deleteCampusFunctionInCampusesRepositoryFile(event.campusId);
        emit(CampusesSuccessState());
      } 
      catch (e) 
      {
        emit(CampusesErrorState(e.toString()));
      }
    });
  }
}