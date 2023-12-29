import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCLeadsMembersListStates.dart';
import 'package:flutter_final_project/Core/Repositories/GDSCLeadsMembersListRepository.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

class GDSCLeadsMembersListBloc extends Bloc<GDSCLeadsMembersListEvent, GDSCLeadsMembersListState> 
{
  final GDSCLeadsMembersListRepository gDSCLeadsMembersRepository;
  StreamSubscription<List<AppUser>>? gDSCLeadsMembersStreamSubscription;
  
  
  GDSCLeadsMembersListBloc({required this.gDSCLeadsMembersRepository}) : super(GDSCLeadsMembersListInitialState()) 
  {
    @override
    Future<void> close() async 
    {
      await gDSCLeadsMembersStreamSubscription!.cancel();
      return super.close();
    }

    on<GDSCLeadsMembersListEvent>((event, emit) {});

    on<CreateGDSCLeadsMembersListEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCLeadsMembersListSuccessOrLoadedState)
        {
          await gDSCLeadsMembersRepository.createAppUserFunctionInGDSCLeadsMembersListRepositoryFile
          (
            name: event.name, 
            email: event.email, 
            role: event.role
          );
        }
      } 
      catch (e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList creation failed.'));
      }
    });

    // on<ReadGDSCLeadsMembersListEvent>((event, emit) 
    // {
    //   try 
    //   {
    //     emit(GDSCLeadsMembersListLoadingState());
    //     final streamResponse = gDSCLeadsMembersRepository.readAppUserFunctionInGDSCLeadsMembersListRepositoryFile(event.userId);
    //     gDSCLeadsMembersStreamSubscription?.cancel();
    //     gDSCLeadsMembersStreamSubscription = streamResponse.listen((campus) 
    //     {
    //       add(ReadGDSCLeadsMembersListEvent(event.userId));
    //     });
    //   } 
    //   catch(e) 
    //   {
    //     emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList loading/reading failed.'));
    //   }
    // });

    on<ReadOneGDSCLeadsMembersListEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCLeadsMembersListLoadingState());
        final user = gDSCLeadsMembersRepository.readOneAppUserFunctionInGDSCLeadsMembersListRepositoryFile(event.userId);
        emit(OneGDSCLeadsMembersListSuccessOrLoadedState(user));
      } 
      catch(e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList loading/reading failed.'));
      }
    });

    on<ReadAllGDSCLeadsMembersListEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCLeadsMembersListLoadingState());
        Stream<List<AppUser>> streamResponse = gDSCLeadsMembersRepository.allGDSCLeadsMembersListFunctionInGDSCLeadsMembersListRepositoryFile();
        emit(GDSCLeadsMembersListSuccessOrLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList loading/reading failed.'));
      }
    });

    on<ReadAllAdminsListEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCLeadsMembersListLoadingState());
        Stream<List<AppUser>> streamResponse = gDSCLeadsMembersRepository.allAdminsListFunctionInGDSCLeadsMembersListRepositoryFile();
        emit(GDSCLeadsMembersListSuccessOrLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList loading/reading failed.'));
      }
    });

    on<ReadAllApprovedGDSCLeadsListEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCLeadsMembersListLoadingState());
        Stream<List<AppUser>> streamResponse = gDSCLeadsMembersRepository.allApprovedGDSCLeadsListFunctionInGDSCLeadsMembersListRepositoryFile();
        emit(GDSCLeadsMembersListSuccessOrLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(const GDSCLeadsMembersListErrorState('ApprovedGDSCLeadList loading/reading failed.'));
      }
    });

    on<ReadAllPendingGDSCLeadsListEvent>((event, emit) 
    {
      try 
      {
        emit(GDSCLeadsMembersListLoadingState());
        Stream<List<AppUser>> streamResponse = gDSCLeadsMembersRepository.allPendingGDSCLeadsListFunctionInGDSCLeadsMembersListRepositoryFile();
        emit(GDSCLeadsMembersListSuccessOrLoadedState(streamResponse));
      } 
      catch(e) 
      {
        emit(const GDSCLeadsMembersListErrorState('PendingGDSCLeadList loading/reading failed.'));
      }
    });

    on<ApproveGDSCLeadEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCLeadsMembersListSuccessOrLoadedState)
        {
          await gDSCLeadsMembersRepository.approveGDSCLeadFunctionInGDSCLeadsMembersListRepositoryFile(event.user);
        }
      } 
      catch (e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList update-ion failed.'));
      }
    });

    on<RemoveGDSCLeadEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCLeadsMembersListSuccessOrLoadedState)
        {
          await gDSCLeadsMembersRepository.removeGDSCLeadFunctionInGDSCLeadsMembersListRepositoryFile(event.user);
        }
      } 
      catch (e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList update-ion failed.'));
      }
    });

    on<UpdateGDSCLeadsMembersListEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCLeadsMembersListSuccessOrLoadedState)
        {
          await gDSCLeadsMembersRepository.updateAppUserFunctionInGDSCLeadsMembersListRepositoryFile(event.user);
        }
      } 
      catch (e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList update-ion failed.'));
      }
    });

    on<DeleteGDSCLeadsMembersListEvent>((event, emit) async 
    {
      try 
      {
        if (state is GDSCLeadsMembersListSuccessOrLoadedState)
        {
          await gDSCLeadsMembersRepository.deleteAppUserFunctionInGDSCLeadsMembersListRepositoryFile(event.userId);
        }
      } 
      catch (e) 
      {
        emit(const GDSCLeadsMembersListErrorState('GDSCLeadsMembersList deletion failed.'));
      }
    });
  }
}