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
        emit(const CampusesErrorState('Campus creation failed.'));
      }
    });

    on<ReadOneCampusEvent>((event, emit) 
    {
      emit(CampusesLoadingState());
      try 
      {
        final campus = campussRepository.readOneCampusFunctionInCampusesRepositoryFile(event.campusId);
        emit(OneCampusSuccessOrLoadedState(campus));
      } 
      catch(e) 
      {
        emit(const CampusesErrorState('OneCampus loading/reading failed.'));
      }
    });

    on<ReadAllCampusesEvent>((event, emit) 
    {
      emit(CampusesLoadingState());
      try 
      {
        Stream<List<Campus>> streamResponse = campussRepository.allCampusesFunctionInCampusesRepositoryFile();
        emit(CampusesLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(const CampusesErrorState('Campus loading/reading failed.'));
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
        emit(const CampusesErrorState('Campus update-ion failed.'));
      }
    });

    on<DeleteCampusEvent>((event, emit) async 
    {
      try 
      {
        if (state is CampusesLoadedState)
        {
          await campussRepository.deleteCampusFunctionInCampusesRepositoryFile(event.campusId);
        }
      } 
      catch (e) 
      {
        emit(const CampusesErrorState('Campus deletion failed.'));
      }
    });
  }
}