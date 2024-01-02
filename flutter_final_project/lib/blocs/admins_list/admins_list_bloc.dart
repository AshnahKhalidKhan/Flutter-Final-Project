import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/admins_list/admins_list_events.dart';
import 'package:flutter_final_project/blocs/admins_list/admins_list_states.dart';
import 'package:flutter_final_project/core/repositories/admins_repository.dart';
import 'package:flutter_final_project/models/user_model.dart';


class AdminsBloc extends Bloc<AdminsEvent, AdminsState> 
{
  final AdminsRepository adminsRepository;
  
  AdminsBloc({required this.adminsRepository}) : super(AdminsInitialState()) 
  {
    on<CreateAdminEvent>((event, emit) async 
    {
      emit(AdminsLoadingState());
      try 
      {
        await adminsRepository.createAdminFunctionInAdminsRepositoryFile
        (
          name: event.name, 
          email: event.email, 
          role: event.role
        );
        emit(AdminAddedState());
      } 
      catch (e) 
      {
        emit(AdminsErrorState(e.toString()));
      }
    });

    on<ReadOneAdminEvent>((event, emit) async
    {
      emit(AdminsLoadingState());
      try 
      {
        final AppUser? admin = await adminsRepository.readOneAdminFunctionInAdminsRepositoryFile(event.userId);
        emit(OneAdminLoadedState(admin!));
      } 
      catch(e) 
      {
        emit(AdminsErrorState(e.toString()));
      }
    });

    on<ReadAllAdminsEvent>((event, emit) 
    {
      emit(AdminsLoadingState());
      try 
      {
        Stream<List<AppUser>> streamResponse = adminsRepository.readAllAdminsFunctionInAdminsRepositoryFile();
        emit(AdminsLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(AdminsErrorState(e.toString()));
      }
    });

    on<UpdateAdminEvent>((event, emit) async 
    {
      emit(AdminsLoadingState());
      try 
      {
        await adminsRepository.updateAdminFunctionInAdminsRepositoryFile(event.user);
        emit(AdminUpdatedState());
      } 
      catch (e) 
      {
        emit(AdminsErrorState(e.toString()));
      }
    });

    on<DeleteAdminEvent>((event, emit) async 
    {
      emit(AdminsLoadingState());
      try 
      {
        await adminsRepository.deleteAdminFunctionInAdminsRepositoryFile(event.userId);
        emit(AdminDeletedState());
      } 
      catch (e) 
      {
        emit(AdminsErrorState(e.toString()));
      }
    });
  }
}